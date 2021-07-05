{- Tian Z (ecburx@burx.vip) -}

module KeyPresses

import IdrisGL

{- Handle keyboard events.
   Press [ Up | Down | LEFT | RIGHT ] buttons to switch between pics.
  
   $ idris2 -p idrisGL IdrisGL.idr
   Main> :l "KeyPresses.idr"
   KeyPresses> :exec main
-}

data Key = Up | Down | Left | Right | Etc

press : Key -> String
press Up    = "up.bmp"
press Down  = "down.bmp"
press Left  = "left.bmp"
press Right = "right.bmp"
press Etc   = "press.bmp"

main : IO ()
main = do
    window <- createWin "Show BMP" (MkRect 30 50 640 480) 0
    screen <- getWinSur window
    loop window screen Etc
    where
      loop : Win -> Sur -> Key -> IO ()
      loop window screen key = do 
        !(loadBMPSur $ press key) `blitSur` screen
        updateWinSur window
        case pollEve of
             EK_UP    => loop window screen Up
             EK_DOWN  => loop window screen Down
             EK_LEFT  => loop window screen Left
             EK_RIGHT => loop window screen Right
             E_QUIT   => pure ()
             _        => loop window screen key