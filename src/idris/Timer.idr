-- Timer.idr
-- Tian Z 2021/7/1

module Timer

import SDL_Support.SDL_sysvideo

frgn : String -> String -> String
frgn func sourceFile = "C:" ++ func ++ ",timer"

-- +---------------+
-- | FFI functions |
-- +---------------+

-- | FFI % display.delayWin()
-- | void delayWin(int ms);
%foreign frgn "delayWin" "timer"
prim_delayWin : Int -> PrimIO ()

-- | Wait a specified number of milliseconds before returning.
export
delayWin : HasIO io => Int -> io ()
delayWin ms = primIO $ prim_delayWin ms