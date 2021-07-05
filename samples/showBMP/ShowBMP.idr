{- Tian Z (ecburx@burx.vip) -}

module ShowBMP

import IdrisGL

{- Show a bmp file.
  
   $ idris2 -p idrisGL IdrisGL.idr
   Main> :l "ShowBMP.idr"
   ShowBMP> :exec main
-}

-- The easiest way to load a bmp:
main : IO ()
main = do 
    win       <- qLoadBMP "hello_world.bmp" (MkRect 0 0 320 240)
    pure         ()

-- Or you can customize details:
main' : IO ()
main' = do
    win       <- createWin "Show BMP" (MkRect 30 50 640 480) 0
    loadBMP2Win  win "hello_world.bmp" (MkRect 10 10 320 240)
    delayWin     2000

-- Or:
main'' : IO ()
main'' = do
    win       <- createWin "Show BMP" (MkRect 30 50 640 480) 0
    screenSur <- getWinSur win
    bmpSur    <- loadBMPSur "hello_world.bmp"
    blitSur      bmpSur screenSur
    updateWinSur win
    delayWin     2000
    freeSur      bmpSur
    closeWin     win

-- Or even:
main''' : IO ()
main''' = do 
    win       <- createWin  "Show BMP" (MkRect 30 50 640 480) 0
    screenSur <- getWinSur   win
    bmpSur    <- loadBMPSur "hello_world.bmp"
    loop         win         bmpSur screenSur
    freeSur      bmpSur
    closeWin     win
    where 
      loop : Win -> Sur -> Sur -> IO ()
      loop win bmp screen = do 
        scaledSur    bmp screen (MkRect 20 20 300 500)
        updateWinSur win
        case pollEve of
             E_QUIT => pure ()
             _      => loop win bmp screen