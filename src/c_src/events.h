/**
 * events.h
 * @author Tian Z ecburx@burx.vip
 */
#define SDL2

#ifdef SDL2
#define SDL_MAIN_HANDLED

#include <SDL2/SDL.h>

#else
#include <SDL.h>
#endif

#ifndef CLIB_EVENTS_H
#define CLIB_EVENTS_H

SDL_Event *nullEve();

int evePending(SDL_Event *eve);

int eveType(SDL_Event *eve);

int eveQuit(SDL_Event *eve);

#endif //CLIB_EVENTS_H
