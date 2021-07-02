CC       = cc
RM       = rm -f
OFLAG    = -o
WFLAG    = -w
SHARE    = -shared
SDL_FLAG = -lSDL2

SOURCE   = $(wildcard *.c)
TARGETS  = $(patsubst %.c, %, $(SOURCE))

all:$(TARGETS)

$(TARGETS):%:%.c
	$(CC) $(SHARE) $< $(WFLAG) $(SDL_FLAG) $(OFLAG) $@.so

.PHONY:clean all
clean:
	-rm -rf $(TARGETS)