{- Tian Z (ecburx@burx.vip) -}

module KeyPresses

import IdrisGL
import IdrisGL.SDL

{- Handle keyboard events.
   Press [ Up | Down | LEFT | RIGHT ] buttons to switch between pics.
  
   $ idris2 -p idrisGL IdrisGL.idr
   Main> :l "KeyPresses.idr"
   KeyPresses> :exec main
-}

main : IO ()
main = do
    window <- createWin $ InWindow "Show BMP" (MkRect 30 50 640 480)
    screen <- getWinSur window
    e      <- newEve

    let bmps = [ !(loadBMPSur "press.bmp")
               , !(loadBMPSur    "up.bmp")
               , !(loadBMPSur  "down.bmp")
               , !(loadBMPSur  "left.bmp")
               , !(loadBMPSur "right.bmp")]

    loop window e screen bmps 0
    where 
      take : Int -> List Sur -> Maybe Sur
      take 0 (x::xs) = Just x
      take i (x::xs) = take (i-1) xs
      take _ _       = Nothing

      loop : Win -> Event -> Sur -> List Sur -> Int -> IO ()
      loop window e screen bmps i = do
        case take i bmps of
             Nothing  => pure ()
             Just bmp => do 
          blitSur bmp screen
          updateWinSur window
          case eveType e of
             E_KEYDOWN EK_UP    => loop window e screen bmps 1
             E_KEYUP   EK_DOWN  => loop window e screen bmps 2
             E_KEYDOWN EK_LEFT  => loop window e screen bmps 3
             E_KEYUP   EK_RIGHT => loop window e screen bmps 4
             E_QUIT             => do freeEve e
                                      pure ()
             _                  => loop window e screen bmps i 