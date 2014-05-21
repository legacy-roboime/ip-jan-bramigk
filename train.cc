#include <iostream>
#include <stdio.h>
#include <ssl-log.h>
#include <messages_robocup_ssl_wrapper.pb.h>
#include <referee.pb.h>
#include <fann.h>

using namespace std;
using namespace ssl_log;

int main() {
  int count = 0;
  FILE *f = fopen("./some.log", "r");

  if (read_header(f) > 0) {

    // count how many vision packets are usable, used to create array
    int total; {
      bool in_match = false;
      SSL_Referee ref;
      total = count_messages(f, [&in_match, &ref] (Message &m) {
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
            return in_match;
          default:
            return false;
        }
      });
    }

#ifdef VERBOSE
    cout << "total usable packets: " << total << endl;
#endif

    // 77 = 12 robots * 6 inputs (x, y, w, vx, vy, vw) + 1 ball (x, y, vx, vy) + 1 current command
    const unsigned int num = 77;
    float prev_state[num];
    float curr_state[num];

    cout << '[';
    while (!feof(f)) {
      Message m;
      if (read_message(f, &m) == 0) {
        cout << ']' << endl;
        break;
      }

      switch (m.message_type) {
        case MESSAGE_BLANK:
          cout << "_" << endl;
          break;
        case MESSAGE_UNKNOWN:
          cout << '?';
          break;
        case MESSAGE_SSL_VISION_2010: {
            SSL_WrapperPacket packet;
            if (!packet.ParseFromArray(m.raw_message, m.message_size)) {
              cout << "!";
            }
            //cout << '.';
          } break;
        case MESSAGE_SSL_REFBOX_2013: {
            SSL_Referee packet;
            if (!packet.ParseFromArray(m.raw_message, m.message_size)) {
              cout << "!";
            }
            //cout << ',';
          } break;
        default:
          cout << '!';
      }

      count++;
    }
    cout << count << " messages found." << endl;
  }
  fclose(f);
  return 0;
}
