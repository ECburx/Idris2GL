//
// Created by Tian Z on 2021/8/11. (ecburxvip@gmail.com)
//

#include <SDL2/SDL.h>
#include <SDL2/SDL_mixer.h>

#include <stdio.h>
#include <stdbool.h>

// sound frequency: 44100, a standard frequency that works on most systems.
#define SOUND_FREQUENCY   44100
// the number of hardware channels, and here we're using 2 channels for stereo.
#define CHANNELS_NUM      2
// sample size, which determines the size of the chunks we use when playing sound.
#define SAMPLE_SIZE       2048
// channel to play on, or -1 for the first free unreserved channel.
#define AVAILABLE_CHANNEL -1

bool mixer_initialized = false;

typedef struct Chunk_t {
    Mix_Chunk      *chunk;
    struct Chunk_t *next;
}    Chunk_t;


typedef struct Music_t {
    Mix_Music      *music;
    struct Music_t *next;
}    Music_t;


Chunk_t *chunks = NULL;
Music_t *musics = NULL;

void appendChunk(Mix_Chunk *c) {
    if (chunks == NULL) {
        chunks = malloc(sizeof(Chunk_t));
        chunks->chunk = c;
        chunks->next  = NULL;
        return;
    }

    Chunk_t *curr;
    for (curr = chunks; curr->next != NULL; curr = curr->next);
    Chunk_t *newNode = malloc(sizeof(Chunk_t));
    newNode->next  = NULL;
    newNode->chunk = c;
    curr->next     = newNode;
}

void freeChunks() {
    if (chunks == NULL) return;

    Chunk_t *curr;
    while (chunks->next) {
        curr = chunks->next;

        Mix_FreeChunk(curr->chunk);
        curr->chunk = NULL;

        chunks->next = curr->next;
        free(curr);
    }
    free(chunks);
    chunks = NULL;
}

void appendMusic(Mix_Music *m) {
    if (musics == NULL) {
        musics = malloc(sizeof(Music_t));
        musics->music = m;
        musics->next  = NULL;
        return;
    }

    Music_t *curr;
    for (curr = musics; curr->next != NULL; curr = curr->next);
    Music_t *newNode = malloc(sizeof(Music_t));
    newNode->next  = NULL;
    newNode->music = m;
    curr->next     = newNode;
}

void freeMusics() {
    if (musics == NULL) return;

    Music_t *curr;
    while (musics->next) {
        curr = musics->next;

        Mix_FreeMusic(curr->music);
        curr->music = NULL;

        musics->next = curr->next;
        free(curr);
    }
    free(musics);
    musics = NULL;
}

void Mix_Destroy() {
    freeChunks();
    freeMusics();
    Mix_Quit();
}

bool mixer_init() {
    if (mixer_initialized) return true;

    if (Mix_OpenAudio(SOUND_FREQUENCY, MIX_DEFAULT_FORMAT, CHANNELS_NUM, SAMPLE_SIZE) < 0) {
        printf("%s\n", Mix_GetError());
        return false;
    }

    atexit(Mix_Destroy);
    mixer_initialized = true;
    return true;
}

void stopMusic() {
    if (Mix_PlayingMusic() != 0) {
        Mix_HaltMusic();
    }
}

void playMusic(char *path, int loops) {
    if (!mixer_init()) return;

    Mix_Music *music = Mix_LoadMUS(path);
    if (music == NULL) {
        printf("%s\n", Mix_GetError());
        return;
    }
    appendMusic(music);

    stopMusic();

    // (loops == 0) plays the music zero times...
    if (Mix_PlayMusic(music, loops) == -1) {
        printf("%s\n", Mix_GetError());
    }
}


void playChunk(char *path) {
    if (!mixer_init()) return;

    Mix_Chunk *chunk = Mix_LoadWAV(path);
    if (chunk == NULL) {
        printf("%s\n", Mix_GetError());
        return;
    }
    appendChunk(chunk);

    // Play chunk one time.
    if (Mix_PlayChannel(AVAILABLE_CHANNEL, chunk, 0) == -1) {
        printf("%s\n", Mix_GetError());
    }
}