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

-- Get the number of milliseconds since the SDL library initialization.
-- WARNING: Int overflow

%foreign frgn "getTicks"
prim_getTicks : Int

export
getTicks : HasIO io => io Int
getTicks = pure prim_getTicks

-- Get the number of seconds since the SDL library initialization.
-- Relatively safe.

%foreign frgn "getSecondsTicks"
prim_getSecondsTicks : Double

export
getSecondsTicks : HasIO io => io Double
getSecondsTicks = pure prim_getSecondsTicks