{- Tian Z (ecburx@burx.vip) -}

module DrawShapes

import IdrisGL
import IdrisGL.Color as Color
import IdrisGL.SDL

{- Draw shapes.
  
   $ idris2 -p idrisGL IdrisGL.idr
   Main> :l "DrawShapes.idr"
   DrawShapes> :exec main
-}

font : String
font = "FreeSerif.ttf"

shapes : Picture
shapes = Pictures [Rectangle   (MkRect 40 40 560 400) (MkColor 60 60 60 255) True
                  ,R_Rectangle (MkRect 50 50 540 380) (MkColor 200 100 200 255) False 20
                  ,Line        (MkCoor 320 10)  (MkCoor 320 470) Color.cyan
                  ,ThickLine   (MkCoor 10  240) (MkCoor 630 240) Color.magenta 10
                  ,Circle      (MkCoor 320 240) (MkColor 200 200 200 100) True  100
                  ,Circle      (MkCoor 320 240) (MkColor 255 200 200 255) False 105
                  ,Rotate 30   (MkCoor 320 240) (Ellipse (MkCoor 320 240) 100 50 Color.blue False)
                  ,Ellipse     (MkCoor 320 240) 100 30 (MkColor 230 230 230 80)  True
                  ,Arc         (MkCoor 320 240) Color.green 50 20 200
                  ,Pixel       (MkCoor 320 240) Color.red
                  ,Trigon      (MkCoor 300 253) (MkCoor 340 253) (MkCoor 320 218) Color.red False
                  ,Pie         (MkCoor 320 240) Color.yellow 40 35 185
                  ,Rotate 15   (MkCoor 50  50)  
                                (Polygon [MkCoor 120  30 
                                         ,MkCoor  40  70
                                         ,MkCoor  40 160
                                         ,MkCoor 120 200
                                         ,MkCoor 200 160
                                         ,MkCoor 200 70] 
                                         (MkColor 30 255 30 255) False)
                  ,Text        "Hello World" 30 font (MkCoor 330 250) Color.red
                  ]

-- The painless way to show shapes:
main : IO ()
main = display 
    (InWindow "Shapes" (MkRect 30 50 640 480))        -- window setting
    (MkColor 43 43 43 255)                            -- background color
    shapes                                            -- Picture

-- Or you can customize details:
main' : IO ()
main' = do 
    win             <- createWin $ InWindow "Shapes" (MkRect 30 50 640 480)
    ren             <- createRenderer win
    setRenderDrawColor ren Color.black

    renderClear        ren
    aaline             ren (MkCoor 10 10) (MkCoor 500 400) Color.green
    thickLine          ren (MkCoor 20 20) (MkCoor 500 300) Color.red 10
    renderPresent      ren

    e               <- newEve
    loop               ren e
    freeRender         ren
    closeWin           win
    where 
      loop : Renderer -> Event -> IO ()
      loop ren e     = do
        case eveType e of
             E_QUIT => pure ()
             _      => loop ren e