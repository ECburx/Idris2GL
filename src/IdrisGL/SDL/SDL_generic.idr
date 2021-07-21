{- Tian Z (ecburx@burx.vip) -}

module IdrisGL.SDL.SDL_generic

{- 
    FFI 
-}

frgn : String -> String
frgn func = "C:" ++ func ++ ",generic"

--

%foreign frgn "nullPointer"
prim_nullPointer : AnyPtr

||| Return a null pointer.
export
nullPtr : AnyPtr
nullPtr = prim_nullPointer