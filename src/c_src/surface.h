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
 * @param path TODO
 * @return
 */
SDL_Surface *loadBMPSur(const char *path);

/**
 * TODO
 * @param win
 * @param path
 */
void loadBMP2Win(SDL_Window *win, const char *path);

/**
 * Use this function to perform a fast surface copy to a destination surface.
 * @param src TODO
 * @param dst
 */
void blitSur(SDL_Surface *src, SDL_Surface *dst);

/**
 * Use this function to perform a fast surface copy to a destination surface, with area specified.
 * @param src TODO
 * @param srcRect
 * @param dst
 * @param dstRect
 */
void blitSurRect(SDL_Surface *src, SDL_Rect *srcRect, SDL_Surface *dst, SDL_Rect *dstRect);

/**
 * TODO
 * @param sur
 */
void freeSur(SDL_Surface *sur);

#endif //CLIB_SURFACE_H
