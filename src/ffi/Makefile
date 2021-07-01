CC       = cc
RM       = rm -f
OFLAG    = -o
WFLAG    = -w
SHARE    = -shared
SDL_FLAG = -lSDL2

OBJS     = display.c
LIB_NAME = display.so

all : $(OBJS)
	$(CC) $(SHARE) $(OBJS) $(WFLAG) $(SDL_FLAG) $(OFLAG) $(LIB_NAME)

clean:
	$(RM) *.so