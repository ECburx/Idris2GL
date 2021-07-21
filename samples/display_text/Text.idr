{- Tian Z (ecburx@burx.vip) -}

module Text

import IdrisGL
import IdrisGL.Color

{- Show text.
  
   $ idris2 -p idrisGL IdrisGL.idr
   Main> :l "Text.idr"
   Text> :exec main
-}

font : String
font = "FreeSerif.ttf"

title : Picture
title = Rotate 10 (MkCoor 490 0) (SolidText "IdrisGL" 
            50 font (MkCoor 490 0) (MkRGB 230 230 230) TS_BOLD TH_NORMAL 0)

solid : Picture
solid = SolidText "Solid Text: Size 20, Color (220,220,220,255) STRIKETHROUGH NORMAL"
            20 font (MkCoor 30 90) (MkRGB 220 220 220) TS_STRIKETHROUGH TH_NORMAL 0

blended : Picture
blended = BlendedText "Blended Text: Size 20, Color (210,210,210,255) ITALIC LIGHT"
            20 font (MkCoor 30 120) (MkRGB 210 210 210) TS_ITALIC TH_LIGHT 0

shaded : Picture
shaded = ShadedText "Shaded Text: Size 20, Color (200,200,200,255) UNDERLINE MONO"
            20 font (MkCoor 30 150) (MkRGB 200 200 200) (MkRGB 100 100 100) TS_UNDERLINE TH_MONO 0

standard : Picture
standard = Text "Idris 2 is a purely functional programming language with first class types."
                18 font (MkCoor 30 200) (MkRGB 190 190 190)

text : Picture
text = Pictures [title, solid, blended, shaded, standard]

-- The painless way to show shapes:
main : IO ()
main = display 
    (InWindow "Text" (MkRect 30 50 720 240))          -- window setting
    (MkRGB 43 43 43)                                  -- background color
    text                                              -- Picture