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
 * @param path The path of the BMP file.
 * @return The pointer of the surface.
 */
SDL_Surface *loadBMPSur(const char *path);

/**
 * Loads and shows a bmp file in a window.
 * @param win The window to show BMP file.
 * @param path The path of the BMP file.
 * @param x The x location of the BMP's upper left corner.
 * @param y The y location of the BMP's upper left corner.
 * @param w The width of the bmp.
 * @param h The height of the bmp.
 */
void loadBMP2Win(SDL_Window *win, const char *path, int x, int y, int w, int h);

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

#endif //CLIB_SURFACE_H
