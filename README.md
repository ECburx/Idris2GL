# Idris2GL

A 2D graphic library for Idris 2, which is inspired by Gloss. IdrisGL uses SDL under the hood, but you won’t need to worry about any of that.

![Logo](./Logo.png)

![Contributor Wanted](./IntroPic.png)

- Provides functions to build 2D vector graphics, animations, simulations and games.
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

> To compile shared libraries with your own SDLs, following SDL dependencies are required:
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

## Special Thanks

- Dr [Edwin Brady](https://github.com/edwinb)

## Maintenance

**Contributor and volunteers will be gratefully welcomed!**

- Maintainer: [Tian Z](https://github.com/ECburx)
