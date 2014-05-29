#include <string.h>
#include "ssl-log.h"

namespace ssl_log {

Message::Message(uint64_t message_size)
    : message_size(message_size)
{
  raw_message = new uint8_t[message_size];
}

Message::~Message()
{
  delete raw_message;
}

size_t fread_uint32(FILE *f, uint32_t *out)
{
  unsigned char bytes[4];
  size_t total = fread(&bytes, sizeof(bytes), 1, f);
  *out = 0 + ((uint32_t)bytes[3] | (uint32_t)bytes[2] << 8 | (uint32_t)bytes[1] << 16 | (uint32_t)bytes[0] << 24);
  return total;
}

size_t fread_uint64(FILE *f, uint64_t *out)
{
  unsigned char bytes[8];
  size_t total = fread(&bytes, sizeof(bytes), 1, f);
  *out = 0 + ((uint64_t)bytes[7] | (uint64_t)bytes[6] << 8  | (uint64_t)bytes[5] << 16 | (uint64_t)bytes[4] << 24 |
        (uint64_t)bytes[3] << 32 | (uint64_t)bytes[2] << 40 | (uint64_t)bytes[1] << 48 | (uint64_t)bytes[0] << 56);
  return total;
}

int read_header(FILE *f)
{
  char head[13];
  uint32_t version = 0;

  // always read 16 bytes
  fread(head, sizeof(char), 12, f);
  fread_uint32(f, &version);

  // and then return
  return strcmp(head, "SSL_LOG_FILE") == 0 ? version : 0;
}

size_t read_message(FILE *f, Message *m)
{
  size_t total =
    fread_uint64(f, &m->timestamp ) +
    fread_uint32(f, (uint32_t *)&m->message_type) +
    fread_uint32(f, &m->message_size);
  delete m->raw_message;
  m->raw_message = new uint8_t[m->message_size];
  return total +
    fread(m->raw_message, sizeof(uint8_t), m->message_size, f);
}

size_t skip_message(FILE *f)
{
  uint32_t size;
  size_t total = 0;
  if (fseek(f, 12, SEEK_CUR) == 0) {
    total += 12;
  }
  total += fread(&size, sizeof(uint32_t), 1, f);
  if (fseek(f, size, SEEK_CUR) == 0) {
    total += size;
  }
  return total;
}


uint32_t count_messages(FILE *f, std::function<bool(Message &)> filter)
{
  uint32_t count = 0;
  fpos_t pos;
  Message m;
  //XXX: f...pos have both a return value that should be dealt with
  fgetpos(f, &pos);
  while (read_message(f, &m) > 0) {
    if (filter(m)) {
      count++;
    }
  }
  fsetpos(f, &pos);
  return count;
}

}
