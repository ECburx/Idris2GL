//
// Created by Tian Z on 2021/7/6. (ecburxvip@gmail.com)
//

#include <SDL2/SDL.h>

#define UNAVAILABLE_EVENT -1

typedef struct {
    SDL_Event *ePtr;
    int       mouseX;
    int       mouseY;
} Event;

Event *newEve() {
    Event *e = malloc(sizeof(Event));
    if (e == NULL) return NULL;
    e->ePtr   = malloc(sizeof(SDL_Event));
    e->mouseX = 0;
    e->mouseY = 0;
    return e;
}

int eveType(Event *e) {
    if (e == NULL) return UNAVAILABLE_EVENT;
    SDL_Event *ePtr = e->ePtr;
    if (ePtr == NULL)return UNAVAILABLE_EVENT;

    if (SDL_PollEvent(ePtr) == 0) return UNAVAILABLE_EVENT;
    return (int) ePtr->type;
}

int keyEveCode(Event *e) {
    if (e == NULL) return UNAVAILABLE_EVENT;
    SDL_Event *ePtr = e->ePtr;
    if (ePtr == NULL)return UNAVAILABLE_EVENT;

    SDL_EventType type = ePtr->type;

    if (type != SDL_KEYDOWN &&
        type != SDL_KEYUP &&
        type != SDL_TEXTEDITING &&
        type != SDL_TEXTINPUT &&
        type != SDL_KEYMAPCHANGED) {
        return UNAVAILABLE_EVENT;
    }

    return (int) ePtr->key.keysym.sym;
}

Event *mouseEveCode(Event *e) {
    SDL_GetMouseState(&(e->mouseX), &(e->mouseY));
    return e;
}

void freeEve(Event *e) {
    free(e->ePtr);
    free(e);
}