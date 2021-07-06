//
// Created by Tian Z on 2021/7/6. (ecburxvip@gmail.com)
//

#include <SDL2/SDL.h>

#ifndef IDRISGL_SDL_VIDEO_H
#define IDRISGL_SDL_VIDEO_H

/**
 * Initializes the SDL library and creates a window with the specified position, dimensions, and flags.
 * @param title The title of the window.
 * @param x The x position of the window.
 * @param y The y position of the window.
 * @param w The width of the window.
 * @param h The height of the window.
 * @param isFullScreen.
 * @return the window that was created or NULL on failure;
 */
SDL_Window *createWin(
        const char *title,
        int x, int y, int w, int h,
        int isFullScreen);

/**
 * Destroy a window.
 * If window is NULL, this function will return immediately.
 * @param win The window to destroy.
 */
void closeWin(SDL_Window *win);

/**
 * Get the SDL surface associated with the window.
 * @param win The window to query.
 * @return The surface associated with the window, or NULL on failure;
 */
SDL_Surface *getWinSur(SDL_Window *win);

/**
 * Copy the window surface to the screen.
 * @param win The window to update.
 */
void updateWinSur(SDL_Window *win);

#endif //IDRISGL_SDL_VIDEO_H
