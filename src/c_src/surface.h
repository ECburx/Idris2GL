/**
 * surface.h
 * @author Tian Z ecburx@burx.vip
 */

#define SDL2

#ifdef SDL2
#define SDL_MAIN_HANDLED

#include <SDL2/SDL.h>

#else
#include <SDL.h>
#endif

#ifndef CLIB_SURFACE_H
#define CLIB_SURFACE_H

/**
 * Use this function to load a surface from a BMP file.
 * @param path
 * @return
 */
SDL_Surface *loadBMP(const char *path);

/**
 * Use this function to perform a fast surface copy to a destination surface.
 * @param src
 * @param dst
 */
void blitSur(SDL_Surface *src, SDL_Surface *dst);

#endif //CLIB_SURFACE_H
