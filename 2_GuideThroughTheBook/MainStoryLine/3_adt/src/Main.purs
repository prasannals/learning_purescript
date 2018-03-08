module Main where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)

data Shape = Circle Point Number
  | Rectangle Point Number Number
  | Line Point Point
  | Text Point String

data Point = Point { x :: Number, y :: Number}

createPoint :: Number -> Number -> Point
createPoint x y = Point {x, y}

exampleLine :: Shape
exampleLine = Line p1 p2
  where
    p1 :: Point
    p1 = Point { x: 0.0, y: 0.0 }

    p2 :: Point
    p2 = Point { x: 100.0, y: 50.0 }


anotherShape :: Shape
anotherShape = Circle (Point {x : 50.0, y : 50.0}) 100.0

moveXY :: Shape -> Number -> Number -> Shape
moveXY (Circle (Point {x,y}) radius) dx dy = (Circle (Point {x:(x + dx), y:(y + dy)}) radius)
moveXY (Rectangle (Point {x,y}) w h) dx dy = (Rectangle (Point {x:(x + dx), y:(y + dy)}) w h)
moveXY (Line (Point {x:x0, y:y0}) (Point {x:x1, y:y1})) dx dy = (Line (Point {x:(x0 + dx), y:(y0 + dy)}) (Point {x:(x1 + dx), y:(y1 + dy)}))
moveXY (Text (Point {x,y}) text) dx dy = (Text (Point {x:(x+dx), y:(y+dy)}) text)


showPoint :: Point -> String
showPoint (Point {x, y}) = "Point : x=" <> (show x) <> ", y=" <> (show y)

showShape :: Shape -> String
showShape (Circle p@(Point {x,y}) radius) = "Circle, " <> (showPoint p) <> " , radius=" <> (show radius)
showShape (Rectangle p@(Point {x,y}) w h) = "Rectangle, " <> (showPoint p) <> ", width=" <> (show w) <> ", height=" <> (show h)
showShape (Line p0@(Point {x:x0, y:y0}) p1@(Point {x:x1, y:y1})) = "Line, " <> (showPoint p0) <> ", " <> (showPoint p1)
showShape (Text p@(Point {x,y}) text) = "Text, " <> (showPoint p) <> ", Text: " <> text


main :: forall e. Eff (console :: CONSOLE | e) Unit
main = log "Hello sailor!"
