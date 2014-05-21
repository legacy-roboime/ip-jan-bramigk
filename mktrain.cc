#include <iostream>
#include <fstream>
#include <stdio.h>
#include <ssl-log.h>
#include <messages_robocup_ssl_wrapper.pb.h>
#include <referee.pb.h>

using namespace std;
using namespace ssl_log;

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
    const unsigned int num = 4; // ball only, for tests
    const unsigned int buffer_size = 120; // Approximatly 1 second.
    float data_buffer[buffer_size][num];

    f_train << total << ' ' << num << ' ' << num << endl;
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
          break;
        case MESSAGE_SSL_VISION_2010:
          if (!wrap.ParseFromArray(m.raw_message, m.message_size))
            cout << '!';
          if (wrap.has_detection() && (wrap.detection().balls_size() > 0)) {
            for (int j = buffer_size; j > 0; j--)
              for (int i = 0; i < num; i++)
                data_buffer[j][i] = data_buffer[j - 1][i];
            SSL_DetectionBall ball = wrap.detection().balls(0);
            data_buffer[0][0] = ball.x();
            data_buffer[0][1] = ball.y();
            data_buffer[0][2] = data_buffer[0][0] - data_buffer[1][0];
            data_buffer[0][3] = data_buffer[0][1] - data_buffer[1][1];
            if (in_match) {
              f_train
                << data_buffer[0][0] << ' '
                << data_buffer[0][1] << ' '
                << data_buffer[0][2] << ' '
                << data_buffer[0][3] << endl
                << data_buffer[buffer_size - 1][0] << ' '
                << data_buffer[buffer_size - 1][1] << ' '
                << data_buffer[buffer_size - 1][2] << ' '
                << data_buffer[buffer_size - 1][3] << endl;
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
