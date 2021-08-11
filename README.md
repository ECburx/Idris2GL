# Idris2GL

A 2D graphic library for Idris 2, which is inspired by Gloss. IdrisGL uses SDL under the hood, but you won’t need to worry about any of that.

![Index1](./img/Index1.gif)

![Index2](./img/Index2.gif)

- Provides functions to build 2D vector graphics, animations, simulations and games.
- Provides `SDL2` , `SDL2_image` , `SDL2_gfx`,  `SDL2_ttf` bindings, by importing `IdrisGL.SDL`.
- Supports most of keyboard events and mouse events.
- Frames per second control.
- Music and sound effects.

## Documentation

[Documentation for the IdrisGL](https://idrisgl.readthedocs.io/)

## Uses

### Install from Source Code

```
git clone https://github.com/ECburx/Idris2GL
cd Idris2GL
make quickInstall
```

> You may want to compiled shared libraries with your own SDLs. Following SDL dependencies is required:
> 
> - SDL
> - SDL_image
> - SDL_ttf
> - SDL_gfx
> - SDL_mixer
> 
> After you installed these dependencies,
> 
> ```
> cd Idris2GL
> make install
> ```

### Import

`$ idris2 -p idrisGL` to load dependencies.

- `import IdrisGL`: basic IdrisGL functions.
- `import IdrisGL.Color`: predefined colors.`
- `import IdrisGL.Random`: unsafe, predictable and limited randomness, for users who need (inaccurate) random data to test graphics. (May be removed in the future.)
- `import IdrisGL.SDL`: SDL2, SDL2_image, SDL2_gfx, SDL2_ttf bindings.

## Dependencies

- SDL2
- SDL2 Image
- SDL2 GFX
- SDL2 TTF
- SDL2 Mixer