{- Tian Z (ecburx@burx.vip) -}

module IdrisGL.Events

import IdrisGL.SDLtypes

frgn : String -> String
frgn func = "C:" ++ func ++ ",events"

-- +---------------+
-- |    Events     |
-- +---------------+

public export
data Eve 
  = E_UNAVAILABLE
  | E_QUIT
  | E_KEYDOWN
  | EK_DOWN
  | EK_UP
  | EK_LEFT
  | EK_RIGHT

EveList : List (Int, Eve)
EveList 
  = [(256        , E_QUIT)
    ,(768        , E_KEYDOWN)
    ,(1073741905 , EK_DOWN)
    ,(1073741906 , EK_UP)
    ,(1073741904 , EK_LEFT)
    ,(1073741903 , EK_RIGHT)
    ]

-- +---------------+
-- | FFI functions |
-- +---------------+

-----------------------------------------------------------
-- int pollEve();
export
%foreign frgn "pollEve"
prim_pollEve : Int

export
pollEve : Eve
pollEve = 
  lookup prim_pollEve EveList
  where lookup : Int -> List (Int, Eve) -> Eve
        lookup code Nil     = E_UNAVAILABLE
        lookup code (x::xs) = 
          if (fst x) == code then (snd x) else lookup code xs