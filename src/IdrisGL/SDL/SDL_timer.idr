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

||| Wait a specified number of milliseconds before returning.
export
delayWin : HasIO io => Int -> io ()
delayWin ms = primIO $ prim_delayWin ms

-- Get the number of milliseconds since the SDL library initialization.
-- WARNING: Int overflow

%foreign frgn "getTicks"
prim_getTicks : Int

||| Get the number of milliseconds since SDL library initialization.
export
getTicks : HasIO io => io Int
getTicks = pure prim_getTicks

-- Get the number of seconds since the SDL library initialization.
-- Relatively safe.

%foreign frgn "getSecondsTicks"
prim_getSecondsTicks : Double

||| Get the number of seconds since SDL library initialization.
export
getSecondsTicks : HasIO io => io Double
getSecondsTicks = pure prim_getSecondsTicks