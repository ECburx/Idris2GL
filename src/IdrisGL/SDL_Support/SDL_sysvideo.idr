{- Tian Z (ecburx@burx.vip) -}

module IdrisGL.SDL_Support.SDL_sysvideo

import System.FFI

import IdrisGL.SDL_Support.SDL_surface
import IdrisGL.SDL_Support.SDL_rect
import IdrisGL.SDL_Support.SDL_video
import IdrisGL.SDL_Support.SDL_shape

mutual
    export
    SDL_Window : Type
    SDL_Window 
        = Struct "SDL_Window" 
        [("magic"                   , AnyPtr)           -- const void *
        ,("id"                      , Int)              -- uint32_t
        ,("title"                   , String)
        ,("icon"                    , Ptr SDL_Surface)
        ,("x"                       , Int)
        ,("y"                       , Int)
        ,("w"                       , Int)
        ,("h"                       , Int)
        ,("min_w"                   , Int)
        ,("min_h"                   , Int)
        ,("max_w"                   , Int)
        ,("max_h"                   , Int)
        ,("flags"                   , Int)              -- uint32_t
        ,("last_fullscreen_flags"   , Int)              -- uint32_t
        ,("windowed"                , SDL_Rect)
        ,("fullscreen_mode"         , SDL_DisplayMode)
        ,("opacity"                 , Double)           -- float
        ,("brightness"              , Double)           -- float
        ,("gamma"                   , Ptr Int)          -- uint16_t *
        ,("saved_gamma"             , Ptr Int)          -- uint16_t *
        ,("surface"                 , Ptr SDL_Surface)
        ,("surface_valid"           , Int)              -- SDL_bool
        ,("is_hiding"               , Int)              -- SDL_bool
        ,("is_destroying"           , Int)              -- SDL_bool
        ,("is_dropping"             , Int)              -- SDL_bool
        ,("shaper"                  , Ptr SDL_WindowShaper)
        ,("hit_test"                , (Ptr SDL_Window -> AnyPtr -> AnyPtr -> Int)) -- SDL_HitTest
        ,("hit_test_data"           , AnyPtr)           -- void *
        ,("data"                    , Ptr SDL_WindowUserData)
        ,("driverdata"              , AnyPtr)           -- void *
        ,("prev"                    , Ptr SDL_Window)
        ,("next"                    , Ptr SDL_Window)
        ]

    SDL_WindowShaper : Type
    SDL_WindowShaper
        = Struct "SDL_WindowShaper"
        [("window"                  , Ptr SDL_Window)
        ,("userx"                   , Int)              -- uint32_t
        ,("usery"                   , Int)              -- uint32_t
        ,("mode"                    , SDL_WindowShapeMode)
        ,("hasshape"                , Int)              -- SDL_bool
        ,("driverdata"              , AnyPtr)
        ]

    SDL_WindowUserData : Type
    SDL_WindowUserData
        = Struct "SDL_WindowUserData"
        [("name"                    , String)
        ,("data"                    , AnyPtr)           -- void *
        ,("next"                    , Ptr SDL_WindowUserData)
        ]