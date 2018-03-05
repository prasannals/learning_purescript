module Main where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Data.Array
import Data.Maybe (fromMaybe)

arr :: Array Int
arr = [[1, 2, 3, 4, 5], [1, 2, 3, 4, 5] ]

loopAdd :: (Array Int) -> Int -> Int -> Int
loopAdd arr acc i = if (i < (length arr))
                      then loopAdd arr (acc + (fromMaybe 0 (arr !! i) )) (i + 1)
                      else acc

twoDAdd :: (Array (Array Int)) -> Int -> Int -> Int
twoDAdd arr acc i = if (i < (length arr))
                      then twoDAdd arr (acc + (loopAdd (fromMaybe [] (arr !! i)) 0 0)) (i + 1)
                      else acc

-- for()

main :: forall e. Eff (console :: CONSOLE | e) Unit
main = do
  log (show (loopAdd arr 0 0) )
