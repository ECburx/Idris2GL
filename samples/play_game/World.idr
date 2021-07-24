{- Tian Z (ecburx@burx.vip) -}

module World

import Data.Vect
import IdrisGL
import IdrisGL.Color

import Map
import Player

--              Map KeyState  Player Position  Hold sword?
data World = WD Map Eve       (Int,Int)        Bool

-- move to specific direction if possible
move : World -> (Int,Int) -> World
move (WD m@(MP _ w h) e (x,y) s) (xM, yM) =
    let (x',y') = (x+xM,y+yM) in
    if  (x' >= 0)   && (y' >= 0)   && 
        (x' <  w)   && (y' <  h)   &&
        (badCode 4) && (badCode 5) && (badCode 6) &&
        not  ((x',y') == (2,1))
    then case (x',y') of
              (2 ,2 )   => WD m E_UNAVAILABLE (x',y') True
              otherwise => WD m E_UNAVAILABLE (x',y') s
    else WD m E_UNAVAILABLE (x ,y ) s
    where badCode : Nat -> Bool
          badCode nat = getBlockCode m (x+xM,y+yM) /= nat

export
initWorld : World
initWorld = WD map1 E_UNAVAILABLE (4,9) False

export
showWD : World -> Picture
showWD (WD m _ (x,y) False) =
    if (x < 4) && (y < 4)
    then  Pictures $ pics ++ [vhMessage]
    else  Pictures   pics
    where pics : List Picture
          pics = map2picture m ++ [player (x,y), villageHead, sword]

showWD (WD m _ (x,y) True) =
    Pictures $ map2picture m ++ [playerS (x,y), villageHead]

export
eventsHandler : Eve -> World -> World
eventsHandler key@(E_KEYDOWN _) (WD m _ pos s) = WD m key pos s
eventsHandler _ w = w

export
timeHandler : Double -> World -> World
timeHandler t w@(WD _ (E_KEYDOWN EK_w) (x,y) _) = move w ( 0,-1)
timeHandler t w@(WD _ (E_KEYDOWN EK_s) (x,y) _) = move w ( 0, 1)
timeHandler t w@(WD _ (E_KEYDOWN EK_a) (x,y) _) = move w (-1, 0)
timeHandler t w@(WD _ (E_KEYDOWN EK_d) (x,y) _) = move w ( 1, 0)
timeHandler _ w                                 = w