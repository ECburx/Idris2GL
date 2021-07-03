/**
 * preset.c
 * @author Tian Z ecburx@burx.vip
 */

#include "preset.h"

#include <stdio.h>

/* BMP INFO */
#define BMP_LOAD_MODE "rb"
#define OFFSET_RATIO  3
#define ELEMENT_SIZE  1

SDL_Window *qLoadBMP(const char *path) {
    /* Get bmp size (width & height) */
    int32_t w, h;
    FILE    *fp    = fopen(path, BMP_LOAD_MODE);
    int     offset = sizeof(uint16_t) * OFFSET_RATIO + sizeof(uint32_t) * OFFSET_RATIO;
    fseek(fp, offset, SEEK_SET);
    fread(&w, ELEMENT_SIZE, sizeof(w), fp);
    fread(&h, ELEMENT_SIZE, sizeof(h), fp);
    fclose(fp);

    /* Create a window which just suits the bmp size (width & height) */
    SDL_Window *win = createWin(path, 0, 0, w, h, SDL_WINDOW_SHOWN);
    if (win == NULL) return NULL;

    /* Load bmp file */
    SDL_Surface *bmp = SDL_LoadBMP(path);
    if (bmp == NULL) {
        printf("%s", SDL_GetError());
        return NULL;
    }

    /* Copy bmp surface to window screen surface */
    SDL_Surface *sur = SDL_GetWindowSurface(win);
    SDL_BlitSurface(bmp, NULL, sur, NULL);
    SDL_UpdateWindowSurface(win);

    return win;
}