{- Tian Z (ecburx@burx.vip) -}

module IdrisGL.DataType

{- Types -}

public export
data Rect : Type where
    MkRect : Int -> Int -> Int -> Int -> Rect

public export
data Color : Type where
    MkColor : Int -> Int -> Int -> Int -> Color

{- Pinter Types -}

-- | SDL_Surface pointer Type.
public export
data Sur : Type where
    MkSur : AnyPtr -> Sur

-- | SDL_Window pointer Type.
public export
data Win : Type where
    MkWin : AnyPtr -> Win

public export
data Renderer : Type where
    MkRenderer : AnyPtr -> Renderer

public export
data Texture : Type where
    MkTexture : AnyPtr -> Texture

{- Datas -}

public export
data Display
    = InWindow String Rect
    | FullWindow

public export
data Picture
    = Blank
    | Image String Rect
    | Bitmap String Rect
    | Pictures (List Picture)