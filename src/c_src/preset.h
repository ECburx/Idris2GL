/**
 * preset.h
 * @author Tian Z ecburx@burx.vip
 */

#define SDL2

#ifdef SDL2
#define SDL_MAIN_HANDLED

#include <SDL2/SDL.h>

#include "video.h"

#else
#include <SDL.h>
#endif

#ifndef CLIB_PRESET_H
#define CLIB_PRESET_H

/**
 * TODO
 */
typedef void(*ioFn)();

/**
 * TODO
 * @param path
 * @return
 */
void qLoadBMP(const char *path);

///**
// * TODO
// * @param win
// * @param f
// */
//void closable(SDL_Window *win, void *f);

#endif //CLIB_PRESET_H
