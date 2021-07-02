module Test

import Video
import Timer

-- a very simple test. TODO: Delete.
main : IO()
main = do win <- createWin "pig" 300 400 300 400 0
          delayWin 2000
          closeWin win
          pure ()