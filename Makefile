CXX ?= clang++
FLAGS = -O2 -std=c++11
INCLUDE = -Issl-log -Iproto
LIBS = -lprotobuf -lfann
SRC = proto/*.cc ssl-log/ssl-log.cc
OUT1 = train
DEFS = -DVERBOSE

.PHONY:
all:
	$(CXX) $(DEFS) $(FLAGS) $(INCLUDE) $(SRC) $(OUT1).cc -o $(OUT1) $(LIBS)
