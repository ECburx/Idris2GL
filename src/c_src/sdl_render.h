//
// Created by Tian Z on 2021/7/6. (ecburxvip@gmail.com)
//

#include <SDL2/SDL.h>

#ifndef IDRISGL_SDL_RENDER_H
#define IDRISGL_SDL_RENDER_H

/**
 * TODO
 * @param win
 * @return
 */
SDL_Renderer *createRenderer(SDL_Window *win);

/**
 * TODO
 * @param renderer
 * @param r
 * @param g
 * @param b
 * @param a
 */
void setRenderDrawColor(SDL_Renderer *renderer, int r, int g, int b, int a);

/**
 * TODO
 * @param renderer
 * @param surface
 * @return
 */
SDL_Texture *createTextureFromSur(SDL_Renderer *renderer, SDL_Surface *surface);

/**
 * TODO
 * @param renderer
 * @param texture
 * @param x
 * @param y
 * @param w
 * @param h
 */
void renderCopy(SDL_Renderer *renderer, SDL_Texture *texture,
                int x, int y, int w, int h);

/**
 * TODO
 * @param renderer
 */
void freeRender(SDL_Renderer *renderer);

#endif //IDRISGL_SDL_RENDER_H
