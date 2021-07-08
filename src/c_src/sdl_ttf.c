//
// Created by Tian Z on 2021/7/8. (ecburxvip@gmail.com)
//

#include "sdl_ttf.h"
#include <stdio.h>

void ttf_init() {
    if (TTF_Init() != 0) {
        printf("%s\n", TTF_GetError());
        return;
    }
    atexit(TTF_Quit);
}

TTF_Font *loadFont(char *str, int size) {
    if (size < MINIMUM_FONT_SIZE) size = MINIMUM_FONT_SIZE;

    TTF_Font *font = TTF_OpenFont(str, size);
    if (!font) printf("Unable to load default font file: %s\n", TTF_GetError());
}

void setFontKerning(TTF_Font *font, int allowed) {
    if (allowed < 0) allowed = 0;
    TTF_SetFontKerning(font, allowed);
}

void setFontHinting(TTF_Font *font, int code) {
    switch (code) {
        case HINTING_NORMAL:
            TTF_SetFontHinting(font, TTF_HINTING_NORMAL);
            return;
        case HINTING_LIGHT:
            TTF_SetFontHinting(font, TTF_HINTING_LIGHT);
            return;
        case HINTING_MONO:
            TTF_SetFontHinting(font, TTF_HINTING_MONO);
            return;
        case HINTING_NONE:
            TTF_SetFontHinting(font, TTF_HINTING_NONE);
            return;
        default:
            return;
    }
}

void setFontStyle(TTF_Font *font, int code) {
    switch (code) {
        case STYLE_NORMAL:
            TTF_SetFontStyle(font, TTF_STYLE_NORMAL);
            return;
        case STYLE_BOLD:
            TTF_SetFontStyle(font, TTF_STYLE_BOLD);
            return;
        case STYLE_ITALIC:
            TTF_SetFontStyle(font, TTF_STYLE_ITALIC);
            return;
        case STYLE_UNDERLINE:
            TTF_SetFontStyle(font, TTF_STYLE_UNDERLINE);
            return;
        case STYLE_STRIKETHROUGH:
            TTF_SetFontStyle(font, TTF_STYLE_STRIKETHROUGH);
            return;
        default:
            return;
    }
}

void drawText(SDL_Renderer *renderer,
              char *str, int size, char *file,
              int x, int y,
              int r, int g, int b, int a) {
    if (str == NULL) return;

    ttf_init();
    TTF_Font *font       = loadFont(file, size);
    if (font == NULL) return;

    int         w, h;
    SDL_Color   color    = {r, g, b, a};
    SDL_Surface *textSur = TTF_RenderText_Blended(font, str, color);
    SDL_Texture *texture = SDL_CreateTextureFromSurface(renderer, textSur);

    SDL_QueryTexture(texture, NULL, NULL, &w, &h);
    SDL_Rect rect = {x, y, w, h};

    SDL_RenderCopy(renderer, texture, NULL, &rect);
    SDL_FreeSurface(textSur);
    TTF_CloseFont(font);
}

void drawSolidText(SDL_Renderer *renderer,
                   char *str, int size, char *file,
                   int style, int kerning, int hinting,
                   int x, int y,
                   int r, int g, int b, int a) {
    if (str == NULL) return;

    ttf_init();
    TTF_Font *font       = loadFont(file, size);
    if (font == NULL) return;

    setFontStyle(font, style);
    setFontKerning(font, kerning);
    setFontHinting(font, hinting);

    int         w, h;
    SDL_Color   color    = {r, g, b, a};
    SDL_Surface *textSur = TTF_RenderText_Solid(font, str, color);
    SDL_Texture *texture = SDL_CreateTextureFromSurface(renderer, textSur);

    SDL_QueryTexture(texture, NULL, NULL, &w, &h);
    SDL_Rect rect = {x, y, w, h};

    SDL_RenderCopy(renderer, texture, NULL, &rect);
    SDL_FreeSurface(textSur);
    TTF_CloseFont(font);
}

void drawBlendedText(SDL_Renderer *renderer,
                     char *str, int size, char *file,
                     int style, int kerning, int hinting,
                     int x, int y,
                     int r, int g, int b, int a) {
    if (str == NULL) return;

    ttf_init();
    TTF_Font *font       = loadFont(file, size);
    if (font == NULL) return;

    setFontStyle(font, style);
    setFontKerning(font, kerning);
    setFontHinting(font, hinting);

    int         w, h;
    SDL_Color   color    = {r, g, b, a};
    SDL_Surface *textSur = TTF_RenderText_Blended(font, str, color);
    SDL_Texture *texture = SDL_CreateTextureFromSurface(renderer, textSur);

    SDL_QueryTexture(texture, NULL, NULL, &w, &h);
    SDL_Rect rect = {x, y, w, h};

    SDL_RenderCopy(renderer, texture, NULL, &rect);
    SDL_FreeSurface(textSur);
    TTF_CloseFont(font);
}

void drawShadedText(SDL_Renderer *renderer,
                    char *str, int size, char *file,
                    int style, int kerning, int hinting,
                    int x, int y,
                    int r1, int g1, int b1, int a1,
                    int r2, int g2, int b2, int a2) {
    if (str == NULL) return;

    ttf_init();
    TTF_Font *font       = loadFont(file, size);
    if (font == NULL) return;

    setFontStyle(font, style);
    setFontKerning(font, kerning);
    setFontHinting(font, hinting);

    int         w, h;
    SDL_Color   color1   = {r1, g1, b1, a1};
    SDL_Color   color2   = {r2, g2, b2, a2};
    SDL_Surface *textSur = TTF_RenderText_Shaded(font, str, color1, color2);
    SDL_Texture *texture = SDL_CreateTextureFromSurface(renderer, textSur);

    SDL_QueryTexture(texture, NULL, NULL, &w, &h);
    SDL_Rect rect = {x, y, w, h};

    SDL_RenderCopy(renderer, texture, NULL, &rect);
    SDL_FreeSurface(textSur);
    TTF_CloseFont(font);
}