/**
 * events.c
 * @author Tian Z ecburx@burx.vip
 */

#include "events.h"

SDL_Event *nullEve() {
    return NULL;
}

int evePending(SDL_Event *eve) {
    return SDL_PollEvent(eve) != 0;
}

int eveType(SDL_Event *eve) {
    return eve->type;
}

int eveQuit(SDL_Event *eve) {
    return eve->type == SDL_QUIT;
}