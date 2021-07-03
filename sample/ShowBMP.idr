{- Tian Z (ecburx@burx.vip) -}

module ShowBMP

import IdrisGL

{- Show a bmp file in 2 seconds.
  
   $ idris2 -p idrisGL IdrisGL.idr
   Main> :l "ShowBMP.idr"
   ShowBMP> :exec main
-}

main : IO()
main = do
    win       <- createWin "pig" 30 30 1000 500 0
    screenSur <- getWinSur win
    bmpSur    <- loadBMP "hello_world.bmp"
    blitSur bmpSur screenSur
    updateWinSur win
    delayWin 2000
    closeWin win
    pure ()