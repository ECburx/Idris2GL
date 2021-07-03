{- Tian Z (ecburx@burx.vip) -}

module IdrisGL.Timer

frgn : String -> String
frgn func = "C:" ++ func ++ ",timer"

-- +---------------+
-- | FFI functions |
-- +---------------+

-----------------------------------------------------------
-- | void delayWin(int ms);
%foreign frgn "delayWin"
prim_delayWin : Int -> PrimIO ()

-- | Wait a specified number of milliseconds before returning.
export
delayWin : HasIO io => Int -> io ()
delayWin ms = primIO $ prim_delayWin ms