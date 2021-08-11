{- Tian Z (ecburx@burx.vip) -}

module World

import Control.Monad.State
import IdrisGL
import IdrisGL.Color

import Board
import Tile

data WorldState   : Type where
     MkWorldState : (board : Board) -> (score : Nat) -> (max : Nat) -> WorldState

fontPath : String
fontPath = "FreeSerif.ttf"

scoreBar : (score : Nat) -> Picture
scoreBar score = Pictures $
    [ SolidText "2048" 40 fontPath (MkCoor logoX logoY) color TS_BOLD TH_NONE 0
    , Text ("Score: " ++ show score) 20 "FreeSerif.ttf" (MkCoor scoreX scoreY) color]
where logoY  : Int
      logoY  = 4 * (tileWidth + tileSpacing)
      logoX  : Int
      logoX  = tileSpacing
      scoreY : Int
      scoreY = 4 * (tileWidth + tileSpacing) + tileSpacing
      scoreX : Int
      scoreX = 3 * tileWidth
      color  : Color
      color  = MkRGB 120 110 100

finishedPic : (win : Bool) -> List Picture
finishedPic win = 
    [ Rectangle (MkRect 0 0 width width) (MkRGBA 200 200 200 200) True 
    , SolidText msg 40 fontPath (MkCoor 60 100) (MkRGB 120 110 100) TS_BOLD TH_NONE 0]
where
    msg : String
    msg with (win) 
        msg | True  = "Well Done!"
        msg | False = "Game Over!"
    width : Int
    width = 4 * (tileWidth + tileSpacing) + tileSpacing

export
initWorld : WorldState
initWorld = MkWorldState initBoard 0 0

export
showWorld : StateT WorldState IO Picture
showWorld = do
    MkWorldState board@(MkBoard _ lose) score maxTile <- get

    -- `case of` cannot build
    -- case the (Bool, Nat) (lose, maxTile) of
    --      (True, _) => pure $ Pictures $ show score board ++ finishedPic False
    --      (_, 2048) => pure $ Pictures $ show score board ++ finishedPic True
    --      _         => pure $ Pictures $ show score board

    if lose 
      then pure $ Pictures $ show score board ++ finishedPic False
      else 
        if maxTile == 2048 
          then pure $ Pictures $ show score board ++ finishedPic True
          else pure $ Pictures $ show score board

where show : (score : Nat) -> (board : Board) -> List Picture
      show s b = scoreBar s :: boardToPic b

export
eventsHandler : (e : Eve) -> StateT WorldState IO ()
eventsHandler (E_KEYDOWN key) = do
    st@(MkWorldState board _ _) <- get
    let newBoard                =  eh board key
    put $ MkWorldState newBoard (boardScore newBoard) (maxTile newBoard)
    playChunk "medium.wav"  -- play sound effect
where eh : Board -> Key -> Board
      eh b EK_UP    = checkAndMove Up    b
      eh b EK_DOWN  = checkAndMove Down  b
      eh b EK_LEFT  = checkAndMove Left  b
      eh b EK_RIGHT = checkAndMove Right b
      eh b _ = b
eventsHandler _ = pure ()

export
timeHandler : (t : Double) -> StateT WorldState IO ()
timeHandler t = pure ()