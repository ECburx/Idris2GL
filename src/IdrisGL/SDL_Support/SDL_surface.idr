{- Tian Z (ecburx@burx.vip) -}

module IdrisGL.SDL_Support.SDL_surface

import System.FFI

import IdrisGL.SDL_Support.SDL_pixels
import IdrisGL.SDL_Support.SDL_rect

export
SDL_Surface : Type
SDL_Surface
    = Struct "SDL_Surface"
    [("flags"           , Int)
    ,("format"          , Ptr SDL_PixelFormat)
    ,("w"               , Int)
    ,("h"               , Int)
    ,("pitch"           , Int)
    ,("pixels"          , AnyPtr)           -- void *
    ,("userdata"        , AnyPtr)           -- void *
    ,("locked"          , Int)
    ,("lock_data"       , AnyPtr)           -- void *
    ,("clip_rect"       , SDL_Rect)
    ,("map"             , AnyPtr)           -- struct SDL_BlitMap *map; /**< Private */
    ,("refcount"        , Int)
    ]