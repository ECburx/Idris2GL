# IMPORTANT: RELEASE_NAME must match that defined in .ipkg.
PACKAGE_NAME     := idrisGL
VERSION          := 1.0
RELEASE_NAME     := $(PACKAGE_NAME)-$(VERSION)

IDRIS            := idris2
MACHINE          := $(shell $(CC) -dumpmachine)
CC               := cc
RM               := rm -f
OFLAG            := -o
WFLAG            := -w
SHARE            := -shared
MKDIR            := mkdir -p
FPIC             := -fPIC

SDL_FLAG         := -lSDL2
SDL_IMG_FLAG     := $(SDL_FLAG) -lSDL2_image
SDL_GFX_FLAG     := $(SDL_FLAG) -lSDL2_gfx
SDL_TTF_FLAG     := $(SDL_FLAG) -lSDL2_ttf

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

SOURCES_CODE     =  $(wildcard *.c)
#SOURCES         =  $(patsubst %.h, %, $(HEADERS))
TARGETS          =  $(patsubst %.c, %.$(SHLIB_SUFFIX), $(SOURCES_CODE))
#OBJECTS         =  $(patsubst %.h, %.o, $(HEADERS))

GENERAL_SOURCES  =  generic random
SDL_SOURCES      =  sdl_events sdl_render sdl_surface sdl_timer sdl_video
SDL_GFX_SOURCES  =  sdl_gfx
SDL_IMG_SOURCES  =  sdl_image
SDL_TTF_SOURCES  =  sdl_ttf

SYS_LIB_DIR      =  $(shell ${IDRIS} --libdir)
INSTALL_DIR      =  $(SYS_LIB_DIR)/$(RELEASE_NAME)/lib/

.PHONY: build install clean

build: $(GENERAL_SOURCES) $(SDL_SOURCES) $(SDL_GFX_SOURCES) $(SDL_IMG_SOURCES) $(SDL_TTF_SOURCES)

$(GENERAL_SOURCES):%:%.c
	$(CC) $(SHARE) $< $(WFLAG) $(OFLAG) $@.$(SHLIB_SUFFIX) $(FPIC)

$(SDL_SOURCES):%:%.c
	$(CC) $(SHARE) $< $(WFLAG) $(SDL_FLAG) $(OFLAG) $@.$(SHLIB_SUFFIX) $(FPIC)

$(SDL_GFX_SOURCES):%:%.c
	$(CC) $(SHARE) $< $(WFLAG) $(SDL_GFX_FLAG) $(OFLAG) $@.$(SHLIB_SUFFIX) $(FPIC)

$(SDL_IMG_SOURCES):%:%.c
	$(CC) $(SHARE) $< $(WFLAG) $(SDL_IMG_FLAG) $(OFLAG) $@.$(SHLIB_SUFFIX) $(FPIC)

$(SDL_TTF_SOURCES):%:%.c
	$(CC) $(SHARE) $< $(WFLAG) $(SDL_TTF_FLAG) $(OFLAG) $@.$(SHLIB_SUFFIX) $(FPIC)

clean:
	-rm -rf $(TARGETS) *.$(SHLIB_SUFFIX) $(INSTALL_DIR)*.$(SHLIB_SUFFIX)

install:
	@if ! [ -d $(INSTALL_DIR) ]; then mkdir -p $(INSTALL_DIR); fi
	install $(TARGETS) $(INSTALL_DIR)