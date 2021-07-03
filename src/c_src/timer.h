/**
 * timer.h
 * @author Tian Z ecburx@burx.vip
 */
#define SDL2

#ifdef SDL2
#define SDL_MAIN_HANDLED

#include <SDL2/SDL.h>

#else
#include <SDL.h>
#endif

#ifndef CLIB_TIMER_H
#define CLIB_TIMER_H

/**
 * Wait a specified number of milliseconds before returning.
 * @param ms the number of milliseconds to delay.
 */
void delayWin(int ms);

#endif //CLIB_TIMER_H
