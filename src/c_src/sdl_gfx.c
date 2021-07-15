//
// Created by Tian Z on 2021/7/7. (ecburxvip@gmail.com)
//
#include <SDL2/SDL.h>
#include <SDL2/SDL2_gfxPrimitives.h>
//#include "SDL2_GFX/SDL2_gfxPrimitives.h"

#include <stdio.h>

void pixel(SDL_Renderer *renderer,
           int x, int y,
           int r, int g, int b, int a) {
    pixelRGBA(renderer, x, y, r, g, b, a);
}

/* Line */

void thickLine(SDL_Renderer *renderer,
               int x1, int y1, int x2, int y2,
               int r, int g, int b, int a,
               int width) {
    thickLineRGBA(renderer, x1, y1, x2, y2, width, r, g, b, a);
}

void aaline(SDL_Renderer *renderer,
            int x1, int y1, int x2, int y2,
            int r, int g, int b, int a) {
    if (aalineRGBA(renderer, x1, y1, x2, y2, r, g, b, a) != 0)
        printf("%s\n", SDL_GetError());
}

/* Rectangle */

void rect(SDL_Renderer *renderer,
          int x, int y, int w, int h,
          int r, int g, int b, int a) {
    if (rectangleRGBA(renderer, x, y, x + w, y + h, r, g, b, a) != 0)
        printf("%s\n", SDL_GetError());
}

void roundedRect(SDL_Renderer *renderer,
                 int x, int y, int w, int h,
                 int r, int g, int b, int a,
                 int rad) {
    roundedRectangleRGBA(renderer, x, y, x + w, y + h,
                         rad, r, g, b, a);
}

void filledRect(SDL_Renderer *renderer,
                int x, int y, int w, int h,
                int r, int g, int b, int a) {
    boxRGBA(renderer, x, y, x + w, y + h, r, g, b, a);
}

void roundedFilledRect(SDL_Renderer *renderer,
                       int x, int y, int w, int h,
                       int r, int g, int b, int a,
                       int rad) {
    roundedBoxRGBA(renderer, x, y, x + w, y + h,
                   rad, r, g, b, a);
}

/* Circle */

void circle(SDL_Renderer *renderer,
            int x, int y,
            int r, int g, int b, int a,
            int rad) {
    circleRGBA(renderer, x, y, rad, r, g, b, a);
}

void aaCircle(SDL_Renderer *renderer,
              int x, int y,
              int r, int g, int b, int a,
              int rad) {
    aacircleRGBA(renderer, x, y, rad, r, g, b, a);
}

void filledCircle(SDL_Renderer *renderer,
                  int x, int y,
                  int r, int g, int b, int a,
                  int rad) {
    filledCircleRGBA(renderer, x, y, rad, r, g, b, a);
}

void thickCircle(SDL_Renderer *renderer,
                 int x, int y,
                 int r, int g, int b, int a,
                 int rad, int width) {
    circleRGBA(renderer, x, y, rad, r, g, b, a);
    if (width <= 1) return;
    if (rad <= 1) return;

    int      odd   = width % 2;
    int      inner = width / 2;
    for (int i     = 1; i <= inner; ++i) {
        circleRGBA(renderer, x, y, rad - i, r, g, b, a);
    }
    for (int i     = 1; i <= inner + odd; ++i) {
        circleRGBA(renderer, x, y, rad + i, r, g, b, a);
    }
}

/* Arc */

void arc(SDL_Renderer *renderer,
         int x, int y,
         int r, int g, int b, int a,
         int rad, int start, int end) {
    arcRGBA(renderer, x, y, rad, start, end, r, g, b, a);
}

/* Ellipse */

void ellipse(SDL_Renderer *renderer,
             int x, int y, int rx, int ry,
             int r, int g, int b, int a) {
    ellipseRGBA(renderer, x, y, rx, ry, r, g, b, a);
}

void filledEllipse(SDL_Renderer *renderer,
                   int x, int y, int rx, int ry,
                   int r, int g, int b, int a) {
    filledEllipseRGBA(renderer, x, y, rx, ry, r, g, b, a);
}

void aaellipse(SDL_Renderer *renderer,
               int x, int y, int rx, int ry,
               int r, int g, int b, int a) {
    aaellipseRGBA(renderer, x, y, rx, ry, r, g, b, a);
}

/* Pie */

void pie(SDL_Renderer *renderer,
         int x, int y,
         int r, int g, int b, int a,
         int rad, int start, int end) {
    pieRGBA(renderer, x, y, rad, start, end, r, g, b, a);
}

void filledPie(SDL_Renderer *renderer,
               int x, int y,
               int r, int g, int b, int a,
               int rad, int start, int end) {
    filledPieRGBA(renderer, x, y, rad, start, end, r, g, b, a);
}

/* Trigon */

void trigon(SDL_Renderer *renderer,
            int x1, int y1, int x2, int y2, int x3, int y3,
            int r, int g, int b, int a) {
    trigonRGBA(renderer, x1, y1, x2, y2, x3, y3, r, g, b, a);
}

void filledTrigon(SDL_Renderer *renderer,
                  int x1, int y1, int x2, int y2, int x3, int y3,
                  int r, int g, int b, int a) {
    filledTrigonRGBA(renderer, x1, y1, x2, y2, x3, y3, r, g, b, a);
}

void aatrigon(SDL_Renderer *renderer,
              int x1, int y1, int x2, int y2, int x3, int y3,
              int r, int g, int b, int a) {
    aatrigonRGBA(renderer, x1, y1, x2, y2, x3, y3, r, g, b, a);
}