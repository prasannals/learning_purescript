module Main where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)

data Shape = Circle Point Number
  | Rectangle Point Number Number
  | Line Point Point
  | Text Point String

data Point = Point { x :: Number, y :: Number}

exampleLine :: Shape
exampleLine = Line p1 p2
  where
    p1 :: Point
    p1 = Point { x: 0.0, y: 0.0 }

    p2 :: Point
    p2 = Point { x: 100.0, y: 50.0 }

anotherShape :: Shape
anotherShape = Circle (Point {x : 50.0, y : 50.0}) 100.0

main :: forall e. Eff (console :: CONSOLE | e) Unit
main = log "Hello sailor!"
