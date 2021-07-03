# IMPORTANT: RELEASE_NAME must match that defined in .ipkg.
PACKAGE_NAME     := idrisGL
VERSION          := 0.0
RELEASE_NAME     := $(PACKAGE_NAME)-$(VERSION)

IDRIS            := idris2
MACHINE          := $(shell $(CC) -dumpmachine)
CC               := cc
RM               := rm -f
OFLAG            := -o
WFLAG            := -w
SHARE            := -shared
SDL_FLAG         := -lSDL2
MKDIR            := mkdir -p

ifneq            (, $(findstring darwin,  $(MACHINE)))
	OS           := darwin
else ifneq       (, $(findstring cygwin,  $(MACHINE)))
	OS           := windows
else ifneq       (, $(findstring mingw,   $(MACHINE)))
	OS           := windows
else ifneq       (, $(findstring windows, $(MACHINE)))
	OS           := windows
else
	OS           := unix
endif

ifeq             ($(OS), darwin)
	SHLIB_SUFFIX := dylib
else ifeq        ($(OS), windows)
	SHLIB_SUFFIX := dll
else
	SHLIB_SUFFIX := so
endif

#HEADERS          =  $(wildcard *.h)
HEADERS          =  events.h surface.h timer.h video.h
SOURCES          =  $(patsubst %.h, %, $(HEADERS))
TARGETS          =  $(patsubst %.h, %.$(SHLIB_SUFFIX), $(HEADERS))
OBJECTS          =  $(patsubst %.h, %.o, $(HEADERS))
SYS_LIB_DIR      =  $(shell ${IDRIS} --libdir)
INSTALL_DIR      =  $(SYS_LIB_DIR)/$(RELEASE_NAME)/lib/

all:$(SOURCES) preset

$(SOURCES):%:%.c
	$(CC) $(SHARE) $< $(WFLAG) $(SDL_FLAG) $(OFLAG) $@.$(SHLIB_SUFFIX)

preset: preset.c preset.h video.h
	$(CC) $(SHARE) preset.c $(WFLAG) $(SDL_FLAG) $(OFLAG) preset.$(SHLIB_SUFFIX) -ldl video.$(SHLIB_SUFFIX)

clean:
	-rm -rf *.o *.$(SHLIB_SUFFIX) $(INSTALL_DIR)*.$(SHLIB_SUFFIX) $(INSTALL_DIR)*.h

install:
	@if ! [ -d $(INSTALL_DIR) ]; then mkdir -p $(INSTALL_DIR); fi
	install $(TARGETS) $(HEADERS) preset.$(SHLIB_SUFFIX) $(INSTALL_DIR)

.PHONY: install clean all