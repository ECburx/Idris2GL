/**
 * image.h
 * @author Tian Z ecburx@burx.vip
 */

#define SDL2

#ifdef SDL2
#define SDL_MAIN_HANDLED

#include <SDL2/SDL.h>
#include <SDL2/SDL_image.h>

#else
#include <SDL.h>
#endif

#ifndef CLIB_IMAGE_H
#define CLIB_IMAGE_H

/**
 * Use this function to load a surface from an image.
 * @param path The path of the IMG file.
 * @return The pointer of the surface.
 */
SDL_Surface *loadIMGSur(char *path);

/**
 * Loads and shows an image in a window.
 * @param win The window to show IMG file.
 * @param path The path of the IMG file.
 * @param x The x location of the IMG's upper left corner.
 * @param y The y location of the IMG's upper left corner.
 * @param w The width of the image.
 * @param h The height of the image.
 */
void loadIMG2Win(SDL_Window *win, char *path, int x, int y, int w, int h);

#endif //CLIB_IMAGE_H
