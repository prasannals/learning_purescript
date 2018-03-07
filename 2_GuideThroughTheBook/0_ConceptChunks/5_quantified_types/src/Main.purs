module Main where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Data.Array

f1 :: forall a. a -> a
f1 ele = ele

addToArr :: forall a. Array a -> a -> Array a
addToArr arr ele = arr <> [ele]

main :: forall e. Eff (console :: CONSOLE | e) Unit
main = do
  log "Hello sailor!"
