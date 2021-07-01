module SDL_Support.SDL_shape

import System.FFI

export
SDL_WindowShapeMode : Type
SDL_WindowShapeMode
    = Struct "SDL_WindowShapeMode"
    [("mode"            , AnyPtr) -- WindowShapeMode
    ,("parameters"      , AnyPtr) -- SDL_WindowShapeParams
    ]