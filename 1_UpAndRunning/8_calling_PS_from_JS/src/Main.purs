module Main where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Data.Array
import Data.Maybe (fromMaybe)

arr :: Array (Array Int)
arr = [[1, 2, 3, 4, 5], [1, 2, 3, 4, 5] ]

loopAdd :: (Array Int) -> Int -> Int -> Int
loopAdd arr acc i = if (i < (length arr))
                      then loopAdd arr (acc + (fromMaybe 0 (arr !! i) )) (i + 1)
                      else acc

twoDAdd :: (Array (Array Int)) -> Int -> Int -> Int
twoDAdd arr acc i = if (i < (length arr))
                      then twoDAdd arr (acc + (loopAdd (fromMaybe [] (arr !! i)) 0 0)) (i + 1)
                      else acc

functionalTwoDAdd :: (Array (Array Int)) -> Int
functionalTwoDAdd arr  = foldl (\ac oneDArr -> ac + (foldl (\acc ele -> acc + ele) 0 oneDArr ) ) 0 arr

fact :: Int -> Int -> Int
fact n acc = if n == 0
              then acc
              else fact (n - 1) (acc * n)

main :: forall e. Eff (console :: CONSOLE | e) Unit
main = do
  log (show (twoDAdd arr 0 0) )
  --log (show (functionalTwoDAdd arr))
