/**
 * surface.c
 * @author Tian Z ecburx@burx.vip
 */

#include "surface.h"

#include <stdio.h>

SDL_Surface *loadBMPSur(const char *path) {
    SDL_Surface *raw = SDL_LoadBMP(path);
    if (raw == NULL) printf("%s", SDL_GetError());
    return raw;
}

void loadBMP2Win(SDL_Window *win, const char *path, int x, int y, int w, int h) {
    SDL_Surface *raw = SDL_LoadBMP(path);
    if (raw == NULL) printf("%s", SDL_GetError());

    SDL_Surface *screen    = SDL_GetWindowSurface(win);
    SDL_Surface *optimized = SDL_ConvertSurface(raw, screen->format, 0);
    SDL_FreeSurface(raw);

    SDL_Rect stretchRect = {x, y, w, h};
    SDL_BlitScaled(optimized, NULL, SDL_GetWindowSurface(win), &stretchRect);
    SDL_UpdateWindowSurface(win);
}

void blitSur(SDL_Surface *src, SDL_Surface *dst) {
    SDL_BlitSurface(src, NULL, dst, NULL);
}

void scaledSur(SDL_Surface *src, SDL_Surface *dst, int x, int y, int w, int h) {
    SDL_Rect stretchRect = {x, y, w, h};
    SDL_BlitScaled(src, NULL, dst, &stretchRect);
}

void freeSur(SDL_Surface *sur) {
    SDL_FreeSurface(sur);
    sur = NULL;
}

