//
// Created by Tian Z on 2021/7/6. (ecburxvip@gmail.com)
//

#include "sdl_video.h"
#include <stdio.h>

SDL_Window *createWin(
        const char *title,
        int x, int y, int w, int h,
        int isFullScreen) {
    /* Window Flag */
    SDL_WindowFlags f;
    if (isFullScreen) {
        f = SDL_WINDOW_FULLSCREEN;
    } else { f = SDL_WINDOW_SHOWN; }

    /* SDL initialization */
    if (SDL_Init(SDL_INIT_VIDEO) < 0) {
        printf("%s", SDL_GetError());
        return NULL;
    }

    /* Creates window */
    SDL_Window *window = SDL_CreateWindow(title, x, y, w, h, f);
    if (window == NULL) printf("%s\n", SDL_GetError());
    return window;
}

void closeWin(SDL_Window *win) {
    if (win == NULL) return;
    SDL_DestroyWindow(win);
    win = NULL;
}

SDL_Surface *getWinSur(SDL_Window *win) {
    return SDL_GetWindowSurface(win);
}

void updateWinSur(SDL_Window *win) {
    SDL_UpdateWindowSurface(win);
}