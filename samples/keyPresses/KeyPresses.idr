{- Tian Z (ecburx@burx.vip) -}

module KeyPresses

import IdrisGL

{- Handle keyboard events.
   Press [ Up | Down | LEFT | RIGHT ] buttons to switch between pics.
  
   $ idris2 -p idrisGL IdrisGL.idr
   Main> :l "KeyPresses.idr"
   KeyPresses> :exec main
-}

partial main : IO ()
main = do
    window <- createWin "Show BMP" 30 50 640 480 0
    screen <- getWinSur window

    let bmps = [ !(loadBMPSur "press.bmp")
               , !(loadBMPSur    "up.bmp")
               , !(loadBMPSur  "down.bmp")
               , !(loadBMPSur  "left.bmp")
               , !(loadBMPSur "right.bmp")]

    loop window screen bmps 0
    where 
      partial take : Int -> List Sur -> Sur
      take 0 (x::xs) = x
      take i (x::xs) = take (i-1) xs

      partial loop : Win -> Sur -> List Sur -> Int -> IO ()
      loop window screen bmps i = do 
        blitSur      (take i bmps) screen
        updateWinSur window
        case pollEve of
             EK_UP    => loop window screen bmps 1
             EK_DOWN  => loop window screen bmps 2
             EK_LEFT  => loop window screen bmps 3
             EK_RIGHT => loop window screen bmps 4
             E_QUIT   => pure ()
             _        => loop window screen bmps i