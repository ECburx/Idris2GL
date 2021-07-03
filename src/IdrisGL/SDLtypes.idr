{- Tian Z (ecburx@burx.vip) -}

module IdrisGL.SDLtypes

import IdrisGL.SDL_Support.SDL_sysvideo
import IdrisGL.SDL_Support.SDL_surface

-- | SDL_Surface pointer Type.
public export
data Sur : Type where
    MkSur : Ptr SDL_Surface -> Sur

-- | SDL_Window pointer Type.
public export
data Win : Type where
    MkWin : Ptr SDL_Window -> Win