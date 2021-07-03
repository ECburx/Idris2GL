{- Tian Z (ecburx@burx.vip) -}

module EventDriven

import IdrisGL

{- TODO
  
   $ idris2 -p idrisGL IdrisGL.idr
   Main> :l "EventDriven.idr"
   ShowBMP> :exec main
-}

main : IO ()
main = 
  do
    win       <- createWin "Event Driven" 30 30 1000 500 0
    screenSur <- getWinSur win
    bmpSur    <- loadBMP   "hello_world.bmp"
    eve       <- nullEve
    loop eve win bmpSur screenSur
  
  where
    loop : Eve -> Win -> Sur -> Sur -> IO ()
    loop event window bmp screen = 
      case evePending event of
           False => do showBmp
                       loop event window bmp screen
           True  => case eveQuit event of
                         True  => do showBmp
                         False => do showBmp
                                     loop event window bmp screen
    where showBmp : IO ()
          showBmp = do blitSur bmp screen
                       updateWinSur window