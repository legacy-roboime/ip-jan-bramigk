#include <iostream>
#include <fstream>
#include <stdio.h>
#include <ssl-log.h>
#include <messages_robocup_ssl_wrapper.pb.h>
#include <referee.pb.h>
#include <cmath>

using namespace std;
using namespace ssl_log;

float command_float(const ::SSL_Referee_Command &cmd);

template<typename T> void shift_buffer(T buffer, uint32_t size, uint32_t isize);
template<typename T> void shift_buffer(T buffer, uint32_t size);

int main() {
  int count = 0, scount = 0, total;
  FILE *f_log = fopen("./some.log", "rb");
  ofstream f_train;
  f_train.open("./train.data");

  if (read_header(f_log) > 0) {
    bool in_match = false;
    SSL_Referee ref;
    SSL_WrapperPacket wrap;

    // count how many vision packets are usable so we can write it on f_train
    total = count_messages(f_log, [&in_match, &ref, &wrap] (Message &m) {
      switch (m.message_type) {
        case MESSAGE_SSL_REFBOX_2013:
          ref.ParseFromArray(m.raw_message, m.message_size);
          switch (ref.stage()) {
            case SSL_Referee_Stage_NORMAL_FIRST_HALF:
            case SSL_Referee_Stage_NORMAL_SECOND_HALF:
            case SSL_Referee_Stage_EXTRA_FIRST_HALF:
            case SSL_Referee_Stage_EXTRA_SECOND_HALF:
            case SSL_Referee_Stage_PENALTY_SHOOTOUT:
              in_match = true;
              break;
            default:
              in_match = false;
          }
          return false;
        case MESSAGE_SSL_VISION_2010:
          wrap.ParseFromArray(m.raw_message, m.message_size);
          return in_match && wrap.has_detection() && wrap.detection().balls_size() > 0;
        default:
          return false;
      }
    });

#ifdef VERBOSE
    cout << "total usable packets: " << total << endl;
#endif

    // 77 = 12 robots * 6 inputs (x, y, w, vx, vy, vw) + 1 ball (x, y, vx, vy) + 1 current command
    const unsigned int n_in = 5; // ball and command only, for tests
    const unsigned int n_out = 4; // ball only, for tests
    const unsigned int buffer_size = 120; // Approximatly 1 second.
    float data_buffer[buffer_size][n_in];
    auto data_buffer_last = data_buffer[buffer_size - 1];
    auto data_buffer_first = data_buffer[0];
    bool match_buffer[buffer_size];
    auto match_buffer_last = &match_buffer[buffer_size - 1];
    auto match_buffer_first = &match_buffer[0];
    float cmd_buf;

    f_train << total << ' ' << n_in << ' ' << n_out << endl;
    cout << '[';

    in_match = false;
    while (!feof(f_log)) {
      Message m;
      if (read_message(f_log, &m) == 0) {
        cout << ']' << endl;
        break;
      }

      switch (m.message_type) {
        case MESSAGE_SSL_REFBOX_2013:
          ref.ParseFromArray(m.raw_message, m.message_size);
          switch (ref.stage()) {
            case SSL_Referee_Stage_NORMAL_FIRST_HALF:
            case SSL_Referee_Stage_NORMAL_SECOND_HALF:
            case SSL_Referee_Stage_EXTRA_FIRST_HALF:
            case SSL_Referee_Stage_EXTRA_SECOND_HALF:
            case SSL_Referee_Stage_PENALTY_SHOOTOUT:
              in_match = true;
              break;
            default:
              in_match = false;
              break;
          }
          cmd_buf = command_float(ref.command());
          break;
        case MESSAGE_SSL_VISION_2010:
          if (!wrap.ParseFromArray(m.raw_message, m.message_size))
            cout << '!';
          if (wrap.has_detection() && (wrap.detection().balls_size() > 0)) {
            shift_buffer(data_buffer, buffer_size, n_in);
            shift_buffer(match_buffer, buffer_size);

            SSL_DetectionBall ball = wrap.detection().balls(0);
            data_buffer_first[0] = ball.x();
            data_buffer_first[1] = ball.y();
            data_buffer_first[2] = data_buffer[0][0] - data_buffer[1][0];
            data_buffer_first[3] = data_buffer[0][1] - data_buffer[1][1];
            data_buffer_first[4] = cmd_buf;
            *match_buffer_first = in_match;

            if (*match_buffer_last) {
              if (fabs(data_buffer_last[0] + data_buffer_last[1] + data_buffer_last[2] + data_buffer_last[3]) <= 0.0000001) {
                f_train << "0 0 0 0 " << data_buffer_last[4] << endl << "0 0 0 0" << endl;
              } else {
                f_train
                  << data_buffer_last[0] << ' '
                  << data_buffer_last[1] << ' '
                  << data_buffer_last[2] << ' '
                  << data_buffer_last[3] << ' '
                  << data_buffer_last[4] << endl
                  << data_buffer_first[0] << ' '
                  << data_buffer_first[1] << ' '
                  << data_buffer_first[2] << ' '
                  << data_buffer_first[3] << endl;
              }
              scount++;
            }
          }
          break;
        default:
          break;
      }

      count++;
    }
    cout << scount << " train points" << endl;
    cout << count << " messages processed" << endl;
  }

  f_train.close();
  fclose(f_log);
  return 0;
}

float command_float(const ::SSL_Referee_Command &cmd) {
  switch (cmd) {
    //case SSL_Referee_Command_HALT: return 0.0;
    case SSL_Referee_Command_STOP: return -1.0;
    case SSL_Referee_Command_NORMAL_START: return 1.0;
    case SSL_Referee_Command_FORCE_START: return 1.0;
    case SSL_Referee_Command_PREPARE_KICKOFF_YELLOW: return 5.0;
    case SSL_Referee_Command_PREPARE_KICKOFF_BLUE: return -5.0;
    case SSL_Referee_Command_PREPARE_PENALTY_YELLOW: return 6.0;
    case SSL_Referee_Command_PREPARE_PENALTY_BLUE: return -6.0;
    case SSL_Referee_Command_DIRECT_FREE_YELLOW: return 7.0;
    case SSL_Referee_Command_DIRECT_FREE_BLUE: return -7.0;
    case SSL_Referee_Command_INDIRECT_FREE_YELLOW: return 8.0;
    case SSL_Referee_Command_INDIRECT_FREE_BLUE: return -8.0;
    case SSL_Referee_Command_TIMEOUT_YELLOW:
    case SSL_Referee_Command_TIMEOUT_BLUE:
    case SSL_Referee_Command_GOAL_YELLOW:
    case SSL_Referee_Command_GOAL_BLUE:
    //case SSL_Referee_Command: return 4.0;
    default: return 0.0;
  }
}

template<typename T>
void shift_buffer(T buffer, uint32_t size, uint32_t isize) {
  for (int j = size; j > 0; j--)
    for (int i = 0; i < isize; i++)
      buffer[j][i] = buffer[j - 1][i];
}

template<typename T>
void shift_buffer(T buffer, uint32_t size) {
  for (int j = size; j > 0; j--)
    buffer[j] = buffer[j - 1];
}
