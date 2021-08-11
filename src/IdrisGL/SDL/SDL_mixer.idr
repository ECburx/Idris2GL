{- Tian Z (ecburx@burx.vip) -}

module IdrisGL.SDL.SDL_mixer

import System.FFI

{- 
    FFI 
-}

frgn : String -> String
frgn func = "C:" ++ func ++ ",sdl_mixer"

-- Music

%foreign frgn "playMusic"
prim_playMusic : String -> Int -> PrimIO ()

||| Play Music.
export
playMusic : HasIO io => (path : String) -> (loops : Int) -> io ()
playMusic path loops = primIO $ prim_playMusic path loops

-- Chunk

%foreign frgn "playChunk"
prim_playChunk : String -> PrimIO ()

||| Play Chunk.
export
playChunk : HasIO io => (path : String) -> io ()
playChunk path = primIO $ prim_playChunk path
