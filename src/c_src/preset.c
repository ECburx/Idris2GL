/**
 * preset.c
 * @author Tian Z ecburx@burx.vip
 */

#include "preset.h"

#include <stdio.h>
#include <stdbool.h>

void qLoadBMP(const char *path, int x, int y, int w, int h) {
    /* SDL initialization */
    if (SDL_Init(SDL_INIT_VIDEO) < 0) {
        printf("%s\n", SDL_GetError());
        return;
    }

    // ignore flags for now. TODO: activate flags.
    /* Create a window which just suits the bmp size (width & height) */
    SDL_Window *win = SDL_CreateWindow(
            path,
            SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED,
            w, h,
            SDL_WINDOW_SHOWN);
    if (win == NULL) {
        printf("%s\n", SDL_GetError());
        return;
    }

    /* Load bmp file */
    SDL_Surface *raw = SDL_LoadBMP(path);
    if (raw == NULL) {
        printf("%s\n", SDL_GetError());
        return;
    }
    SDL_Surface *screen    = SDL_GetWindowSurface(win);
    SDL_Surface *optimized = SDL_ConvertSurface(raw, screen->format, 0);
    SDL_FreeSurface(raw);

    /* Apply the image stretched. */
    SDL_Rect  stretchRect = {x, y, w, h};

    /* Copy bmp surface to window screen surface */
    bool quit = false;
    SDL_Event e;
    while (!quit) {
        while (SDL_PollEvent(&e) != 0) {
            if (e.type == SDL_QUIT) quit = true;
        }
        SDL_BlitScaled(optimized, NULL, screen, &stretchRect);
        SDL_UpdateWindowSurface(win);
    }

    SDL_FreeSurface(optimized);
    SDL_DestroyWindow(win);
}

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

void qLoadIMG(char *path, int x, int y, int w, int h) {
    int  imgFlags = getImgFlags(path);
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

    /* SDL initialization */
    if (SDL_Init(SDL_INIT_VIDEO) < 0) {
        printf("%s\n", SDL_GetError());
        return;
    }

    // ignore flags for now. TODO: activate flags.
    /* Create a window which just suits the image size (width & height) */
    SDL_Window *win = SDL_CreateWindow(
            path,
            SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED,
            w, h,
            SDL_WINDOW_SHOWN);
    if (win == NULL) {
        printf("%s\n", SDL_GetError());
        return;
    }

    SDL_Surface *screen    = SDL_GetWindowSurface(win);
    SDL_Surface *optimized = SDL_ConvertSurface(raw, screen->format, 0);
    SDL_FreeSurface(raw);

    /* Apply the image stretched. */
    SDL_Rect  stretchRect = {x, y, w, h};

    /* Copy bmp surface to window screen surface */
    bool quit     = false;
    SDL_Event e;
    while (!quit) {
        while (SDL_PollEvent(&e) != 0) {
            if (e.type == SDL_QUIT) quit = true;
        }
        SDL_BlitScaled(optimized, NULL, screen, &stretchRect);
        SDL_UpdateWindowSurface(win);
    }

    SDL_FreeSurface(optimized);
    SDL_DestroyWindow(win);
}