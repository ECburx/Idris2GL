//
// Created by Tian Z on 2021/7/6. (ecburxvip@gmail.com)
//

#include "sdl_events.h"

int pollEve() {
    SDL_Event e;
    if (SDL_PollEvent(&e) == 0) return UNAVAILABLE_EVENT;
    switch (e.type) {
        case SDL_QUIT:
            return (int) SDL_QUIT;
        case SDL_KEYDOWN:
            return (int) e.key.keysym.sym;
        default:
            return UNAVAILABLE_EVENT;
    }
}