//
// Created by Tian Z on 2021/7/6. (ecburxvip@gmail.com)
//

#include <SDL2/SDL.h>

#include <stdio.h>
#include <stdbool.h>

bool sdl_initialized = 0;

bool sdl_init() {
    if (sdl_initialized) return true;
    if (SDL_Init(SDL_INIT_VIDEO) < 0) {
        printf("%s", SDL_GetError());
        return false;
    }
    sdl_initialized = true;
    atexit(SDL_Quit);
    return true;
}

void closeWin(SDL_Window *win) {
    SDL_DestroyWindow(win);
    win = NULL;
    SDL_Quit();
}

SDL_Window *createWin(
        const char *title,
        int x, int y, int w, int h,
        int isFullScreen) {
    /* Window Flag */
    SDL_WindowFlags f;
    if (isFullScreen) {
        f = SDL_WINDOW_FULLSCREEN;
    } else { f = SDL_WINDOW_SHOWN; }

    if (!sdl_init()) return NULL;

    /* Creates window */
    SDL_Window *window = SDL_CreateWindow(title, x, y, w, h, f);
    if (window == NULL) printf("%s\n", SDL_GetError());

    return window;
}

SDL_Surface *getWinSur(SDL_Window *win) {
    return SDL_GetWindowSurface(win);
}

void updateWinSur(SDL_Window *win) {
    SDL_UpdateWindowSurface(win);
}