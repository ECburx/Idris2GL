/**
 * video.h
 * @author Tian Z ecburx@burx.vip
 */

#define SDL2

#ifdef SDL2
#define SDL_MAIN_HANDLED

#include <SDL2/SDL.h>

#else
#include <SDL.h>
#endif

#ifndef CLIB_DISPLAY_H
#define CLIB_DISPLAY_H

/**
 * Initializes the SDL library and creates a window with the specified position, dimensions, and flags.
 * @param title The title of the window.
 * @param x The x position of the window.
 * @param y The y position of the window.
 * @param w The width of the window.
 * @param h The height of the window.
 * @param flags
 * @return the window that was created or NULL on failure;
 */
SDL_Window *createWin(const char *title, int x, int y, int w, int h, int flags);

/**
 * Destroy a window.
 * If window is NULL, this function will return immediately.
 * @param win The window to destroy.
 */
void closeWin(SDL_Window *win);

#endif //CLIB_DISPLAY_H
