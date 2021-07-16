//
// Created by Tian Z on 2021/7/6. (ecburxvip@gmail.com)
//

#include <SDL2/SDL.h>

void delayWin(int ms) {
    SDL_Delay(ms);
}

int getTicks() {
    return SDL_GetTicks();
}

double getSecondsTicks() {
    return SDL_GetTicks() / 1000.0;
}