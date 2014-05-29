#ifndef _SSL_LOG_H
#define _SSL_LOG_H

#include <stdio.h>
#include <stdint.h>
#include <functional>

// Specs: http://robocupssl.cpe.ku.ac.th/gamelogs
namespace ssl_log {

enum MessageType : uint32_t {
  MESSAGE_BLANK           = 0, // (ignore message)
  MESSAGE_UNKNOWN         = 1, // (try to guess message type by parsing the data)
  MESSAGE_SSL_VISION_2010 = 2,
  MESSAGE_SSL_REFBOX_2013 = 3
};

struct Message {
  uint64_t timestamp;
  MessageType message_type;
  uint32_t message_size;
  uint8_t *raw_message;

  Message(uint64_t message_size=0);
  ~Message();
};

// will return the version, or 0 on error
int read_header(FILE *f);

size_t read_message(FILE *f, Message *m);

size_t skip_message(FILE *f);

uint32_t count_messages(FILE *f, std::function<bool(Message &)> filter=[](Message &){ return true; });
//uint32_t count_messages(FILE *f) {
//  return count_messages(f, [](Message&){ return true; });
//}

}

#endif // _SSL_LOG_H
