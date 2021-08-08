{- Tian Z (ecburx@burx.vip) -}

module Board

import Data.Vect
import Decidable.Equality

import IdrisGL
import IdrisGL.Random

import Tile

||| A board contains 16 (4*4) tiles.
public export
data Board : Type where
     MkBoard : (board : Vect 4 (Vect 4 Nat)) -> (lose : Bool) -> Board

||| All accpetable user operations.
public export
data Operation = Up | Down | Left | Right

||| Returns a list of positions of all empty tile (zero tile) in a board.
zeros : (board : Board) -> List (Fin 4, Fin 4)
zeros (MkBoard b _) = zeros' b
where
    zeros' : Vect n (Vect 4 Nat) -> List (Fin n, Fin 4)
    zeros' Nil     = Nil
    zeros' (l::ls) = 
        let   is   = (\(i, j) => (FS i, j)) <$> zeros' ls
        in if elem 0 l 
        then  ((\j => (FZ, j)) <$> findIndices (== 0) l) ++ is 
        else  is

data Movability : List (Fin 4, Fin 4) -> Type where
    Able :  (possibility   :      (Fin 4, Fin 4)) 
         -> (possibilities : List (Fin 4, Fin 4)) 
         -> Movability $ possibility :: possibilities

unableToMove : Movability [] -> Void
unableToMove _ impossible

isAbleToMove : (board : Board) -> Dec $ Movability $ zeros board
isAbleToMove board = isAbleToMove' $ zeros board
where 
    isAbleToMove' : (ps : List (Fin 4, Fin 4)) -> Dec $ Movability ps
    isAbleToMove' Nil     = No unableToMove
    isAbleToMove' (p::ps) = Yes $ Able p ps

addTile : (board : Board) -> Board
addTile board@(MkBoard b True) = board
addTile board@(MkBoard b False) with (randomPick $ zeros board)
    addTile board@(MkBoard b False) | Just (i,j) = MkBoard (replaceAt i (replaceAt j 2 (index i b)) b) False
    addTile board@(MkBoard b False) | Nothing    = board

emptyBoard : Board
emptyBoard = MkBoard (replicate 4 (replicate 4 0)) False

export
initBoard : Board
initBoard = addTile $ addTile emptyBoard

upMergeLine : Vect 4 Nat -> Vect 4 Nat
upMergeLine line = combine $ reformat line
where
    reformat : Vect m Nat -> Vect m Nat
    reformat (0::ts) = snoc (reformat ts) 0
    reformat (t::ts) = t :: reformat ts
    reformat Nil     = Nil

    combine  : Vect m Nat -> Vect m Nat
    combine (x::y::xs) with (x == y)
        combine (x::y::xs) | True  = snoc ((x+y) :: combine xs) 0
        combine (x::y::xs) | False = x :: combine (y::xs)
    combine xs = xs

move : Operation -> (board : Board) -> Board
move op b@(MkBoard _ True) = b
move op (MkBoard board False) = MkBoard (move' op board) False
where
    move' : Operation -> Vect 4 (Vect 4 Nat) -> Vect 4 (Vect 4 Nat)
    move' Up    b = upMergeLine <$> b
    move' Down  b = (reverse . upMergeLine . reverse) <$> b
    move' Left  b = transpose $ move' Up   (transpose b)
    move' Right b = transpose $ move' Down (transpose b)

export
boardToPic : (board : Board) -> List Picture
boardToPic (MkBoard b _) = boardToPic' 0 b
where 
    lineToPic   : (i : Int) -> (j : Int) -> (ts : Vect n Nat) -> List Picture
    lineToPic   i j (t::ts) = tileToPic i j t :: lineToPic i (j+1) ts
    lineToPic   _ _ Nil     = Nil

    boardToPic' : (i : Int) -> (ls : Vect n (Vect 4 Nat)) -> List Picture
    boardToPic' i   (l::ls) = lineToPic i 0 l ++ boardToPic' (i+1) ls
    boardToPic' _   Nil     = Nil

export
checkAndMove : (op : Operation) -> (board : Board) -> Board
checkAndMove op board with (isAbleToMove board)
    checkAndMove op board | Yes prf    = addTile $ move op board
    checkAndMove op board | No  contra = check [Up, Down, Left, Right] board
    where check : (os : Vect n Operation) -> (board : Board) -> Board
          check Nil (MkBoard b _) = MkBoard b True
          check (o::os) board = 
            case isAbleToMove $ move o board of
                 No  contra  => check os board
                 Yes prf     => addTile $ move op board

export
boardScore : (board : Board) -> Nat
boardScore (MkBoard b _) = sum $ sum <$> b

export
maxTile : (board : Board) -> Nat
maxTile (MkBoard b _) = foldl max 0 (foldl max 0 <$> b)