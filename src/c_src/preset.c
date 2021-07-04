/**
 * preset.c
 * @author Tian Z ecburx@burx.vip
 */

#include "preset.h"

#include <stdio.h>
#include <stdbool.h>

/* BMP INFO */
#define BMP_LOAD_MODE "rb"
#define OFFSET_RATIO  3
#define ELEMENT_SIZE  1

void qLoadBMP(const char *path) {
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
    if (win == NULL) return;
    SDL_Surface *sur = SDL_GetWindowSurface(win);

    /* Load bmp file */
    SDL_Surface *bmp = SDL_LoadBMP(path);
    if (bmp == NULL) {
        printf("%s", SDL_GetError());
        return;
    }

    /* Copy bmp surface to window screen surface */
    bool    quit   = false;
    SDL_Event   e;
    while (!quit) {
        while (SDL_PollEvent(&e) != 0) {
            if (e.type == SDL_QUIT) quit = true;
        }
        SDL_BlitSurface(bmp, NULL, sur, NULL);
        SDL_UpdateWindowSurface(win);
    }

    SDL_FreeSurface(bmp);
    SDL_DestroyWindow(win);
}
//void closable(SDL_Window *win, void *f) {
//    if (win == NULL) return;
//}