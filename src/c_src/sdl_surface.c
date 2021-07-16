//
// Created by Tian Z on 2021/7/6. (ecburxvip@gmail.com)
//

#include <SDL2/SDL.h>

#include <stdio.h>

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