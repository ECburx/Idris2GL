/**
 * image.c
 * @author Tian Z ecburx@burx.vip
 */

#include <stdio.h>
#include "image.h"

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
    return raw;
}

void loadIMG2Win(SDL_Window *win, char *path, int x, int y, int w, int h) {
    SDL_Surface *raw = loadIMGSur(path);
    if (raw == NULL) return;

    SDL_Surface *screen    = SDL_GetWindowSurface(win);
    SDL_Surface *optimized = SDL_ConvertSurface(raw, screen->format, 0);
    SDL_FreeSurface(raw);

    SDL_Rect stretchRect = {x, y, w, h};
    SDL_BlitScaled(optimized, NULL, SDL_GetWindowSurface(win), &stretchRect);
    SDL_UpdateWindowSurface(win);
    SDL_FreeSurface(optimized);
}