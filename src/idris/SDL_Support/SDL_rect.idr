module SDL_Support.SDL_rect

import System.FFI

export
SDL_Rect : Type
SDL_Rect
    = Struct "SDL_Rect"
    [("x"               , Int)
    ,("y"               , Int)
    ,("w"               , Int)
    ,("h"               , Int)
    ]