module Main where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)

func :: forall a b. (a -> b -> b) -> a -> b -> b
func anotherFunc d1 d2 = anotherFunc d1 d2

doCalc :: Int -> String -> String
doCalc i s = s <> (show i)

myAwesomeFunc = (\first second -> (first + (first * second)))

main :: forall e. Eff (console :: CONSOLE | e) Unit
main = do
  log "Hello sailor!"
