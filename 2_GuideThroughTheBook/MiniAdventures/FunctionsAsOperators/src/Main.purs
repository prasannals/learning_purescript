module Main where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)

infixl 8 doCalc as ~~

doCalc :: Int -> Int -> Int
doCalc first second = (first * first) + (second * second)

main :: forall e. Eff (console :: CONSOLE | e) Unit
main = do
  log "Hello sailor!"
