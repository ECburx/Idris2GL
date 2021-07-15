//
// Created by Tian Z on 2021/7/6. (ecburxvip@gmail.com)
//

#include <SDL2/SDL.h>
#include <SDL2/SDL_image.h>

#include <stdio.h>

char *getSuffix(char *fn) {
    int s = 0, i = 0;
    while (fn[s] != '\0') {
        if (fn[s] == '.') i = s;
        s++;
    }
    if (s && i) return fn + i;
    return NULL;
}

int getImgFlags(char *path) {
    int  imgFlags;
    char *suffix = getSuffix(path);
    if (strcmp(suffix, ".PNG") == 0 || strcmp(suffix, ".png") == 0) {
        imgFlags = IMG_INIT_PNG;
    } else if (strcmp(suffix, ".JPG") == 0 || strcmp(suffix, ".jpg") == 0) {
        imgFlags = IMG_INIT_JPG;
    } else if (strcmp(suffix, ".TIF") == 0 || strcmp(suffix, ".tif") == 0) {
        imgFlags = IMG_INIT_TIF;
    } else if (strcmp(suffix, ".WEBP") == 0 || strcmp(suffix, ".webp") == 0) {
        imgFlags = IMG_INIT_WEBP;
    } else {
        printf("Can only load .png, .jpg, .tif, .webp format images.\n");
        return 0;
    }
    return imgFlags;
}

SDL_Surface *loadIMGSur(char *path) {
    int imgFlags = getImgFlags(path);
    if (!imgFlags) return NULL;

    /* Initialize image loading */
    if (!(IMG_Init(imgFlags) & imgFlags)) {
        printf("SDL_image could not initialize! SDL_image Error: %s\n", IMG_GetError());
        return NULL;
    }

    SDL_Surface *raw = IMG_Load(path);
    if (raw == NULL) printf("%s\n", IMG_GetError());
    atexit(IMG_Quit);
    return raw;
}

void loadIMG(SDL_Renderer *renderer, char *path,
             int x, int y, int w, int h) {
    int imgFlags = getImgFlags(path);
    if (!imgFlags) return;

    /* Initialize image loading */
    if (!(IMG_Init(imgFlags) & imgFlags)) {
        printf("SDL_image could not initialize! SDL_image Error: %s\n", IMG_GetError());
        return;
    }

    SDL_Surface *raw = IMG_Load(path);
    if (raw == NULL) {
        printf("%s\n", IMG_GetError());
        return;
    }
    atexit(IMG_Quit);

    SDL_Texture *texture = SDL_CreateTextureFromSurface(renderer, raw);
    if (texture == NULL) {
        printf("%s", SDL_GetError());
        return;
    }

    SDL_Rect stretchRect = {x, y, w, h};
    SDL_RenderCopy(renderer, texture, NULL, &stretchRect);
}
