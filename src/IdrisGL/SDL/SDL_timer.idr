{- Tian Z (ecburx@burx.vip) -}

module IdrisGL.SDL.SDL_timer

{- 
    FFI 
-}

frgn : String -> String
frgn func = "C:" ++ func ++ ",sdl_timer"

--

%foreign frgn "delayWin"
prim_delayWin : Int -> PrimIO ()

export
delayWin : HasIO io => Int -> io ()
delayWin ms = primIO $ prim_delayWin ms

-- 

%foreign frgn "getTicks"
prim_getTicks : Int

export
getTicks : HasIO io => io Int
getTicks = pure prim_getTicks