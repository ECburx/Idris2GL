//
// Created by Tian Z on 2021/7/6. (ecburxvip@gmail.com)
//

#include <SDL2/SDL.h>

#ifndef IDRISGL_SDL_SURFACE_H
#define IDRISGL_SDL_SURFACE_H

/**
 * Use this function to load a surface from a BMP file.
 * @param path The path of the BMP file.
 * @return The pointer of the surface.
 */
SDL_Surface *loadBMPSur(const char *path);

/**
 * Use this function to perform a fast surface copy to a destination surface.
 * @param src The pointer of the surface to scale.
 * @param dst The pointer of the destination surface.
 */
void blitSur(SDL_Surface *src, SDL_Surface *dst);

/**
 * Performs a scaled surface copy to a destination surface.
 * @param src The pointer of the surface to scale.
 * @param dst The pointer of the destination surface.
 * @param x The x location of the src's upper left corner.
 * @param y The y location of the src's upper left corner.
 * @param w The width of the src.
 * @param h The height of the src.
 */
void scaledSur(SDL_Surface *src, SDL_Surface *dst, int x, int y, int w, int h);

/**
 * Releases a surface resources.
 * @param sur SDL_Surface.
 */
void freeSur(SDL_Surface *sur);

#endif //IDRISGL_SDL_SURFACE_H
