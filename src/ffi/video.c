/**
 * video.c
 * @author Tian Z ecburx@burx.vip
 */

#include <stdio.h>

#include "video.h"

SDL_Window *createWin(
        const char *title,
        int x, int y,
        int w, int h,
        int flags) {
    // ignore flags for now

    /* SDL initialization */
    if (SDL_Init(SDL_INIT_VIDEO) < 0) {
        printf("%s", SDL_GetError());
        return NULL;
    }

    /* Creates window */
    SDL_Window *window = SDL_CreateWindow(title, x, y, w, h, SDL_WINDOW_SHOWN);
    if (window == NULL) printf("%s", SDL_GetError());
    return window;
}

void closeWin(SDL_Window *win) {
    if (win == NULL) return;
    SDL_DestroyWindow(win);
    win = NULL;
}

