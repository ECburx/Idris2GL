/**
 * surface.c
 * @author Tian Z ecburx@burx.vip
 */

#include <stdio.h>

#include "surface.h"

SDL_Surface *loadBMP(const char *path) {
    SDL_Surface *sur = SDL_LoadBMP(path);
    if (sur == NULL) printf("%s", SDL_GetError());
    return sur;
}

void blitSur(SDL_Surface *src, SDL_Surface *dst) {
    SDL_BlitSurface(src, NULL, dst, NULL);
}