{- Tian Z (ecburx@burx.vip) -}

module ShowBMP

import IdrisGL

{- Show a bmp file in 2 seconds.
  
   $ idris2 -p idrisGL IdrisGL.idr
   Main> :l "ShowBMP.idr"
   ShowBMP> :exec main
-}

-- The easiest way to load a bmp.
main : IO ()
main = do win <- qLoadBMP "hello_world.bmp"
          delayWin 2000
          closeWin win

-- Or you can customize details.
main' : IO()
main' = do
    win       <- createWin "Show BMP" 30 50 640 480 0
    screenSur <- getWinSur win
    bmpSur    <- loadBMPSur "hello_world.bmp"
    blitSur bmpSur screenSur
    updateWinSur win
    delayWin 2000
    closeWin win
    pure ()