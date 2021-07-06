{- Tian Z (ecburx@burx.vip) -}

module KeyPresses

import IdrisGL

{- Handle keyboard events.
   Press [ Up | Down | LEFT | RIGHT ] buttons to switch between pics.
  
   $ idris2 -p idrisGL IdrisGL.idr
   Main> :l "KeyPresses.idr"
   KeyPresses> :exec main
-}

main : IO ()
main = do
    window <- createWin "Show BMP" (MkRect 30 50 640 480) 0
    screen <- getWinSur window

    let bmps = [ !(loadBMPSur "press.bmp")
               , !(loadBMPSur    "up.bmp")
               , !(loadBMPSur  "down.bmp")
               , !(loadBMPSur  "left.bmp")
               , !(loadBMPSur "right.bmp")]

    loop window screen bmps 0
    where 
      take : Int -> List Sur -> Maybe Sur
      take 0 (x::xs) = Just x
      take i (x::xs) = take (i-1) xs
      take _ _       = Nothing

      loop : Win -> Sur -> List Sur -> Int -> IO ()
      loop window screen bmps i = do
        case take i bmps of
             Nothing  => pure ()
             Just bmp => do 
          blitSur bmp screen
          updateWinSur window
          case pollEve of
             E_KEY EK_UP    => loop window screen bmps 1
             E_KEY EK_DOWN  => loop window screen bmps 2
             E_KEY EK_LEFT  => loop window screen bmps 3
             E_KEY EK_RIGHT => loop window screen bmps 4
             E_QUIT         => pure ()
             _              => loop window screen bmps i 