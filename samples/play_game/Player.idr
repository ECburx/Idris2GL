{- Tian Z (ecburx@burx.vip) -}

module Player

import IdrisGL
import IdrisGL.Color

import Map

pos         : (Int,Int) -> Rect
pos         (x,y) = MkRect (x*blockWidth) (y*blockWidth) blockWidth blockWidth

export
player      : (Int,Int) -> Picture
player      (x,y) = Image "png/Player.png"      (pos (x,y))

export
playerS     : (Int,Int) -> Picture
playerS     (x,y) = Image "png/PlayerS.png"     (pos (x,y))

export
villageHead : Picture
villageHead       = Image "png/VillageHead.png" (pos (2,1))

export
sword       : Picture
sword             = Image "png/Sword.png"       (pos (2,2))

export
vhMessage   : Picture
vhMessage         = ShadedText 
                    "IT'S DANGEROUS! TAKE THIS!" 
                    10 
                    "FreeSerif.ttf" 
                    (MkCoor 30 5) 
                    Color.white
                    (MkRGBA  43  43  43 200) 
                    TS_BOLD
                    TH_NONE
                    0