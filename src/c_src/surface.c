/**
 * surface.c
 * @author Tian Z ecburx@burx.vip
 */

#include "surface.h"

#include <stdio.h>

SDL_Surface *loadBMPSur(const char *path) {
    SDL_Surface *bmp = SDL_LoadBMP(path);
    if (bmp == NULL) printf("%s", SDL_GetError());
    return bmp;
}

void loadBMP2Win(SDL_Window *win, const char *path) {
    SDL_Surface *bmp = SDL_LoadBMP(path);
    if (bmp == NULL) printf("%s", SDL_GetError());
    SDL_BlitSurface(bmp, NULL, SDL_GetWindowSurface(win), NULL);
    SDL_UpdateWindowSurface(win);
}

void blitSur(SDL_Surface *src, SDL_Surface *dst) {
    SDL_BlitSurface(src, NULL, dst, NULL);
}

void blitSurRect(SDL_Surface *src, SDL_Rect *srcRect, SDL_Surface *dst, SDL_Rect *dstRect) {
    SDL_BlitSurface(src, srcRect, dst, dstRect);
}

void freeSur(SDL_Surface *sur) {
    SDL_FreeSurface(sur);
    sur = NULL;
}

