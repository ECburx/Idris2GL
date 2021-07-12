# IdrisGL
A Graphics Library for Idris2, based on SDL2.

- Provides painless functions to build 2D vector graphics, animations and simulations.
- Also provides `SDL2` , `SDL2_image` , `SDL2_gfx`,  `SDL2_ttf` bindings.
- Supports most of keyboard events.
- 2D Shapes.
- Animations.
- Simulations. (In Progress)
- Play games. (Not yet)

## Build

1. Navigate to `src`.
2. `$ idris2 --build idrisGL.ipkg` builds the libraries.
3. `$ idris2 --install idrisGL.ipkg` installs the packages into Idris2 prefix.
4. `$ idris2 --clean idrisGL.ipkg` cleans everything.

## Dependencies

- SDL2
- SDL2 Image
- SDL2 GFX
- SDL2 TTF

## Samples

`$ idris2 -p idrisGL IdrisGL.idr` to load dependencies.

### Displaying a bmp file or showing pictures in other formats.

- `samples/showBMP/ShowBMP.idr`
- `samples/showIMG/ShowIMG.idr`
- Or use SDL2 binding functions.

```
display : Display -> Color -> Picture -> IO ()
```

![Sample1](./img/sample1.png)

### Handling Key Presses Events

- `samples/keyPresses/KeyPresses.idr`
- Press [ Up | Down | LEFT | RIGHT ] buttons to switch between pics.
- Another example of using bindings.

![Sample2](./img/sample2.png)

### Draw shapes

- `sample/drawShapes/DrawShapes.idr`

```
display : Display -> Color -> Picture -> IO ()
```



![Sample3](./img/sample3.png)

### Displaying text

- `sample/text/Text.idr`

```
display : Display -> Color -> Picture -> IO ()
```



![sample4](./img/sample4.png)

### Animation - Clock

- `sample/animate_clock/Clock.idr`

```
animate : Display -> Color 
       -> (Integer -> Picture)
       -> IO ()
```

![sample5](./img/sample5.gif)

### Simulation - K-means clustering

- `sample/simulation_kmeans/Kmeans.idr`

```
simulate : Display -> Color 
        -> Integer
        -> model
        -> (model -> Picture)
        -> (Integer -> model -> model)
        -> IO ()
```

![Sample6](./img/sample6.gif)
