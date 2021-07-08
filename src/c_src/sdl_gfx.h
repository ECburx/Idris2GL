//
// Created by Tian Z on 2021/7/7. (ecburxvip@gmail.com)
//

#include <SDL2/SDL.h>
#include <SDL2/SDL2_gfxPrimitives.h>
//#include "SDL2_GFX/SDL2_gfxPrimitives.h"

#ifndef IDRISGL_SDL_GFX_H
#define IDRISGL_SDL_GFX_H

void pixel(SDL_Renderer *renderer,
           int x, int y,
           int r, int g, int b, int a);

/* Line */

void thickLine(SDL_Renderer *renderer,
               int x1, int y1, int x2, int y2,
               int r, int b, int g, int a,
               int width);

void aaline(SDL_Renderer *renderer,
            int x1, int y1, int x2, int y2,
            int r, int g, int b, int a);

/* Rectangle */

void rect(SDL_Renderer *renderer,
          int x, int y, int w, int h,
          int r, int g, int b, int a);

void roundedRect(SDL_Renderer *renderer,
                 int x, int y, int w, int h,
                 int r, int g, int b, int a,
                 int rad);

void filledRect(SDL_Renderer *renderer,
                int x, int y, int w, int h,
                int r, int g, int b, int a);

void roundedFilledRect(SDL_Renderer *renderer,
                       int x, int y, int w, int h,
                       int r, int g, int b, int a,
                       int rad);

/* Circle */

void circle(SDL_Renderer *renderer,
            int x, int y,
            int r, int g, int b, int a,
            int rad);

void aaCircle(SDL_Renderer *renderer,
              int x, int y,
              int r, int g, int b, int a,
              int rad);

void filledCircle(SDL_Renderer *renderer,
                  int x, int y,
                  int r, int g, int b, int a,
                  int rad);

/* Arc */

void arc(SDL_Renderer *renderer,
         int x, int y,
         int r, int g, int b, int a,
         int rad, int start, int end);

/* Ellipse */

void ellipse(SDL_Renderer *renderer,
             int x, int y, int rx, int ry,
             int r, int g, int b, int a);

void filledEllipse(SDL_Renderer *renderer,
                   int x, int y, int rx, int ry,
                   int r, int g, int b, int a);

void aaellipse(SDL_Renderer *renderer,
               int x, int y, int rx, int ry,
               int r, int g, int b, int a);

/* Pie */

void pie(SDL_Renderer *renderer,
         int x, int y,
         int r, int g, int b, int a,
         int rad, int start, int end);

void filledPie(SDL_Renderer *renderer,
               int x, int y,
               int r, int g, int b, int a,
               int rad, int start, int end);

/* Trigon */

void trigon(SDL_Renderer *renderer,
            int x1, int y1, int x2, int y2, int x3, int y3,
            int r, int g, int b, int a);

void filledTrigon(SDL_Renderer *renderer,
                  int x1, int y1, int x2, int y2, int x3, int y3,
                  int r, int g, int b, int a);

void aatrigon(SDL_Renderer *renderer,
              int x1, int y1, int x2, int y2, int x3, int y3,
              int r, int g, int b, int a);

#endif //IDRISGL_SDL_GFX_H
