{- Tian Z (ecburx@burx.vip) -}

module IdrisGL.SDL_Support.SDL_pixels

import System.FFI

SDL_Color : Type
SDL_Color
    = Struct "SDL_Color"
    [("r"               , Int)              -- uint8_t
    ,("g"               , Int)              -- uint8_t
    ,("b"               , Int)              -- uint8_t
    ,("a"               , Int)              -- uint8_t
    ]

SDL_Palette : Type
SDL_Palette
    = Struct "SDL_Palette"
    [("ncolors"         , Int)
    ,("colors"          , Ptr SDL_Color)
    ,("version"         , Int)              -- uint32_t
    ,("refcount"        , Int)
    ]

export
SDL_PixelFormat : Type
SDL_PixelFormat
    = Struct "SDL_PixelFormat"
    [("format"          , Int)              -- uint32_t
    ,("palette"         , Ptr SDL_Palette)
    ,("BitsPerPixel"    , Int)              -- uint8_t
    ,("BytesPerPixel"   , Int)              -- uint8_t
    ,("padding"         , Ptr Int)          -- uint8_t[2]
    ,("Rmask"           , Int)              -- uint32_t
    ,("Gmask"           , Int)              -- uint32_t
    ,("Bmask"           , Int)              -- uint32_t
    ,("Amask"           , Int)              -- uint32_t
    ,("Rloss"           , Int)              -- uint8_t
    ,("Gloss"           , Int)              -- uint8_t
    ,("Bloss"           , Int)              -- uint8_t
    ,("Aloss"           , Int)              -- uint8_t
    ,("Rshift"          , Int)              -- uint8_t
    ,("Gshift"          , Int)              -- uint8_t
    ,("Bshift"          , Int)              -- uint8_t
    ,("Ashift"          , Int)              -- uint8_t
    ,("refcount"        , Int)
    ,("next"            , Ptr SDL_PixelFormat)
    ]