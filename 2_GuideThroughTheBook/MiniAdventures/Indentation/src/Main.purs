module Main where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)

calc :: Int -> Int
calc num = (num * a)
  + b where
    a :: Int
    a = 10

    b :: Int
    b = 20

func :: Int -> Int -> Boolean
func a b = if (a == 1)
             then if (b == 2)
                 then true
                 else false
             else false

main :: forall e. Eff (console :: CONSOLE | e) Unit
main = do
  log "Hello sailor!"
