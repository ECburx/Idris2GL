# IdrisGL
A Graphics Library for Idris2, based on SDL2.

(in progress) (just a few basic functions)

- Key Presses Events in progress.

## Build

1. Navigate to `src`.
2. `$ idris2 --build idrisGL.ipkg` builds the libraries.
3. `$ idris2 --install idrisGL.ipkg` installs the packages into Idris2 prefix.
4. `$ idris2 --clean idrisGL.ipkg` cleans everything.

## Dependencies

- SDL 2.0.10
  - `apt-get install libsdl1.2-dev libsdl-image1.2-dev libsdl-mixer1.2-dev libsdl-ttf2.0-dev`

## Samples

`$ idris2 -p idrisGL IdrisGL.idr` to load dependencies.

### Showing a bmp file. 

- `samples/ShowBMP.idr`

- Shows 4 possible ways to load, scale and show a bmp file, with each ways in different customization level.

### Handling Key Presses Events

- `samples/KeyPresses.idr`
- Press [ Up | Down | LEFT | RIGHT ] buttons to switch between pics.

