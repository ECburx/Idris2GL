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

#define UNAVAILABLE_EVENT -1

/**
 * Poll for currently pending events.
 * @return Event code.
 */
int pollEve();

#endif //CLIB_EVENTS_H
