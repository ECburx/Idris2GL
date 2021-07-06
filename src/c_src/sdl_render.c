//
// Created by Tian Z on 2021/7/6. (ecburxvip@gmail.com)
//

#include "sdl_render.h"
#include <stdio.h>

SDL_Renderer *createRenderer(SDL_Window *win) {
    SDL_Renderer *renderer = SDL_CreateRenderer(
            win, -1, SDL_RENDERER_ACCELERATED);
    if (renderer == NULL) printf("%s", SDL_GetError());
    return renderer;
}

void setRenderDrawColor(SDL_Renderer *renderer, int r, int g, int b, int a) {
    SDL_SetRenderDrawColor(renderer, r, g, b, a);
}

SDL_Texture *createTextureFromSur(SDL_Renderer *renderer, SDL_Surface *surface) {
    SDL_Texture *texture = SDL_CreateTextureFromSurface(renderer, surface);
    if (texture == NULL) printf("%s", SDL_GetError());
    return texture;
}

void renderClear(SDL_Renderer *renderer) {
    SDL_RenderClear(renderer);
}

void renderPresent(SDL_Renderer *renderer) {
    SDL_RenderPresent(renderer);
}

void renderCopy(SDL_Renderer *renderer, SDL_Texture *texture,
                int x, int y, int w, int h) {
    SDL_Rect stretchRect = {x, y, w, h};
    SDL_RenderCopy(renderer, texture, NULL, &stretchRect);
}

void freeRender(SDL_Renderer *renderer) {
    SDL_DestroyRenderer(renderer);
    renderer = NULL;
}