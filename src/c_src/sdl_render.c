//
// Created by Tian Z on 2021/7/6. (ecburxvip@gmail.com)
//

#include <SDL2/SDL.h>

#include <stdio.h>

SDL_Renderer *createRenderer(SDL_Window *window) {
    SDL_Renderer *renderer = SDL_CreateRenderer(
            window, -1, SDL_RENDERER_ACCELERATED);
    if (renderer == NULL) {
        printf("%s", SDL_GetError());
        return NULL;
    }
    SDL_SetRenderDrawBlendMode(renderer, SDL_BLENDMODE_BLEND);
    return renderer;
}

SDL_Texture *createTargetTexture(SDL_Window *window, SDL_Renderer *renderer) {
    int winW, winH;
    SDL_GetWindowSize(window, &winW, &winH);
    SDL_Texture *texture = SDL_CreateTexture(
            renderer,
            SDL_PIXELFORMAT_ABGR8888,
            SDL_TEXTUREACCESS_TARGET,
            winW, winH);
    if (texture == NULL) {
        printf("%s", SDL_GetError());
        return NULL;
    }
    SDL_SetTextureBlendMode(texture, SDL_BLENDMODE_BLEND);
    return texture;
}

void setRenderTarget(SDL_Renderer *renderer, SDL_Texture *texture) {
    SDL_SetRenderTarget(renderer, texture);
}

void resetRenderTarget(SDL_Renderer *renderer) {
    SDL_SetRenderTarget(renderer, NULL);
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
    SDL_Rect dstRect = {x, y, w, h};
    SDL_RenderCopy(renderer, texture, NULL, &dstRect);
}

void renderCopyEx(SDL_Renderer *renderer, SDL_Texture *texture,
                  int x, int y, int w, int h,
                  double angle, int cx, int cy, int flip) {
    SDL_Rect  dstRect = {x, y, w, h};
    SDL_Point center  = {cx, cy};
    SDL_RenderCopyEx(renderer, texture, NULL, &dstRect, angle, &center, flip);
}

void renderCopyExWin(SDL_Window *window, SDL_Renderer *renderer, SDL_Texture *texture,
                     double angle, int cx, int cy, int flip) {
    int winW, winH;
    SDL_GetWindowSize(window, &winW, &winH);
    SDL_Rect  dstRect = {0, 0, winW, winH};
    SDL_Point center  = {cx, cy};
    SDL_RenderCopyEx(renderer, texture, NULL, &dstRect, angle, &center, flip);
}

void freeRender(SDL_Renderer *renderer) {
    SDL_DestroyRenderer(renderer);
    renderer = NULL;
}

/*
 * Basic Shapes.
 */

void renderFillRect(SDL_Renderer *renderer,
                    int x, int y, int w, int h,
                    int r, int g, int b, int a) {
    SDL_SetRenderDrawColor(renderer, r, g, b, a);
    SDL_Rect rect = {x, y, w, h};
    SDL_RenderFillRect(renderer, &rect);
}

void renderDrawRect(SDL_Renderer *renderer,
                    int x, int y, int w, int h,
                    int r, int g, int b, int a) {
    SDL_SetRenderDrawColor(renderer, r, g, b, a);
    SDL_Rect rect = {x, y, w, h};
    SDL_RenderDrawRect(renderer, &rect);
}

void renderDrawLine(SDL_Renderer *renderer,
                    int x1, int y1, int x2, int y2,
                    int r, int g, int b, int a) {
    SDL_SetRenderDrawColor(renderer, r, g, b, a);
    SDL_RenderDrawLine(renderer, x1, y1, x2, y2);
}

void renderDrawPoint(SDL_Renderer *renderer,
                     int x, int y,
                     int r, int g, int b, int a) {
    SDL_SetRenderDrawColor(renderer, r, g, b, a);
    SDL_RenderDrawPoint(renderer, x, y);
}