/**
 * preset.h
 * @author Tian Z ecburx@burx.vip
 */

#define SDL2

#ifdef SDL2
#define SDL_MAIN_HANDLED

#include <SDL2/SDL.h>

#else
#include <SDL.h>
#endif

#ifndef CLIB_PRESET_H
#define CLIB_PRESET_H

/**
 * Loads, scales and shows a BMP file in one window.
 * @param path The path of the BMP file.
 * @param x The x location of the BMP's upper left corner.
 * @param y The y location of the BMP's upper left corner.
 * @param w The width of the bmp.
 * @param h The height of the bmp.
 */
void qLoadBMP(const char *path, int x, int y, int w, int h);

#endif //CLIB_PRESET_H
