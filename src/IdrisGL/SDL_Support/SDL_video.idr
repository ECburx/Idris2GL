{- Tian Z (ecburx@burx.vip) -}

module IdrisGL.SDL_Support.SDL_video

import System.FFI

export
SDL_DisplayMode : Type
SDL_DisplayMode
    = Struct "SDL_DisplayMode"
    [("format"          , Int)              -- uint32_t
    ,("w"               , Int)
    ,("h"               , Int)
    ,("refresh_rate"    , Int)
    ,("driverdata"      , AnyPtr)           -- void *
    ]