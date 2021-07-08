//
// Created by Tian Z on 2021/7/6. (ecburxvip@gmail.com)
//

#include <SDL2/SDL.h>
#include <SDL2/SDL_image.h>

#ifndef IDRISGL_SDL_IMAGE_H
#define IDRISGL_SDL_IMAGE_H

/**
 * Use this function to load a surface from an image.
 * @param path The path of the IMG file.
 * @return The pointer of the surface.
 */
SDL_Surface *loadIMGSur(char *path);

#endif //IDRISGL_SDL_IMAGE_H
