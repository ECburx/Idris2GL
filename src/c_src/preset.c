/**
 * preset.c
 * @author Tian Z ecburx@burx.vip
 */

#include "preset.h"

#include <stdio.h>
#include <stdbool.h>

void qLoadBMP(const char *path, int x, int y, int w, int h) {
    /* SDL initialization */
    if (SDL_Init(SDL_INIT_VIDEO) < 0) {
        printf("%s", SDL_GetError());
        return;
    }

    // ignore flags for now. TODO: activate flags.
    /* Create a window which just suits the bmp size (width & height) */
    SDL_Window *win = SDL_CreateWindow(
            path,
            SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED,
            w, h,
            SDL_WINDOW_SHOWN);
    if (win == NULL) {
        printf("%s", SDL_GetError());
        return;
    }
    SDL_Surface *sur = SDL_GetWindowSurface(win);

    /* Load bmp file */
    SDL_Surface *raw = SDL_LoadBMP(path);
    if (raw == NULL) {
        printf("%s", SDL_GetError());
        return;
    }
    SDL_Surface *screen    = SDL_GetWindowSurface(win);
    SDL_Surface *optimized = SDL_ConvertSurface(raw, screen->format, 0);
    SDL_FreeSurface(raw);

    /* Apply the image stretched. */
    SDL_Rect  stretchRect = {x, y, w, h};

    /* Copy bmp surface to window screen surface */
    bool quit = false;
    SDL_Event e;
    while (!quit) {
        while (SDL_PollEvent(&e) != 0) {
            if (e.type == SDL_QUIT) quit = true;
        }
        SDL_BlitScaled(optimized, NULL, sur, &stretchRect);
        SDL_UpdateWindowSurface(win);
    }

    SDL_FreeSurface(optimized);
    SDL_DestroyWindow(win);
}

