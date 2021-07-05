{- Tian Z (ecburx@burx.vip) -}

module ShowIMG

import IdrisGL

{- Show an image file.
  
   $ idris2 -p idrisGL IdrisGL.idr
   Main> :l "ShowIMG.idr"
   ShowIMG> :exec main
-}

-- The easiest way to load an image:
main : IO ()
main = do 
    win       <- qLoadIMG "loaded.png" (MkRect 0 0 320 240)
    pure         ()

-- Or you can customize details:
main' : IO ()
main' = do
    win       <- createWin "Show IMG" (MkRect 30 50 640 480) 0
    loadIMG2Win  win "loaded.png" (MkRect 10 10 320 240)
    delayWin     2000

-- Or:
main'' : IO ()
main'' = do
    win       <- createWin "Show IMG" (MkRect 30 50 640 480) 0
    screenSur <- getWinSur win
    imgSur    <- loadIMGSur "loaded.png"
    blitSur      imgSur screenSur
    updateWinSur win
    delayWin     2000
    freeSur      imgSur
    closeWin     win

-- Or even:
main''' : IO ()
main''' = do 
    win       <- createWin  "Show IMG" (MkRect 30 50 640 480) 0
    screenSur <- getWinSur   win
    imgSur    <- loadIMGSur "loaded.png"
    loop         win         imgSur screenSur
    freeSur      imgSur
    closeWin     win
    where 
      loop : Win -> Sur -> Sur -> IO ()
      loop win img screen = do 
        scaledSur    img screen (MkRect 20 20 300 500)
        updateWinSur win
        case pollEve of
             E_QUIT => pure ()
             _      => loop win img screen