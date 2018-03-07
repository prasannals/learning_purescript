## Algebraic Data Types and Pattern Matching

```
data Shape = Circle Point Number
  | Rectangle Point Number Number
  | Line Point Point
  | Text Point String

data Point = Point { x :: Number, y :: Number}
```
![](https://i.imgur.com/nSTjL33.jpg)

* "Shape" is the name of the ADT
* Type Constructors can have any name, including the same name as the ADT but both live in different name spaces
* Arguments can be any of number (including 0). Arguments can be any primitive type, records, arrays and even other ADTs.
* "|" syntax separates different Type Constructors for the ADT. There can be any number of these (including just one type constructor)

##### A few more examples
```
data Maybe a = Nothing | Just a

data List a = Nil | Cons a (List a)
```

### Using ADTs

```
exampleLine :: Shape
exampleLine = Line p1 p2
  where
    p1 :: Point
    p1 = Point { x: 0.0, y: 0.0 }

    p2 :: Point
    p2 = Point { x: 100.0, y: 50.0 }

anotherShape :: Shape
anotherShape = Circle (Point {x : 50.0, y : 50.0}) 100.0
```


### So... how do I use the ADTs? We need to use pattern matching in order to get the values inside the ADTs

Let's say we want a function to give a text representation of the Point ADT
```
showPoint :: Point -> String
showPoint (Point {x, y}) = "Point : x=" <> (show x) <> ", y=" <> (show y)
```

![](https://i.imgur.com/hudD3Qt.png)

#### Short Detour - Record Puns

In the above example, I've not bound the property "x" to any local variable. This might have confused a few. This is called a Record Pun. We can use the name of the property directly and a local variable with the same name will be created. In our case, "x" and "y" are the property names but since we've used them in pattern matching without binding them to any local variable, automatically, two local variables "x" and "y" will be created and the values of property "x" and "y" will be assigned to them.

We can use Record Puns to create ADTs too. Example :

```
createPoint :: Number -> Number -> Point
createPoint x y = Point {x, y}
-- normally, we'd have done something like "createPoint x y = Point {x: x, y :y}"
-- thats valid too. But unnecessary.
-- Since the name of the local variables matches the name of the property, we can use them directly.
```

#### Getting back to how we use ADTs :

```
showShape :: Shape -> String
showShape (Circle p@(Point {x,y}) radius) = "Circle, " <> (showPoint p) <> " , radius=" <> (show radius)
showShape (Rectangle p@(Point {x,y}) w h) = "Rectangle, " <> (showPoint p) <> ", width=" <> (show w) <> ", height=" <> (show h)
showShape (Line p0@(Point {x:x0, y:y0}) p1@(Point {x:x1, y:y1})) = "Line, " <> (showPoint p0) <> ", " <> (showPoint p1)
showShape (Text p@(Point {x,y}) text) = "Text, " <> (showPoint p) <> ", Text: " <> text
```

![Imgur](https://i.imgur.com/s7Ienrg.jpg)

#### Make sure you match all possible type constructors. Else we get an error

```
showShape :: Shape -> String
showShape (Circle p@(Point {x,y}) radius) = "Circle, " <> (showPoint p) <> " , radius=" <> (show radius)
showShape (Rectangle p@(Point {x,y}) w h) = "Rectangle, " <> (showPoint p) <> ", width=" <> (show w) <> ", height=" <> (show h)
showShape (Line p0@(Point {x:x0, y:y0}) p1@(Point {x:x1, y:y1})) = "Line, " <> (showPoint p0) <> ", " <> (showPoint p1)
-- showShape (Text p@(Point {x,y}) text) = "Text, " <> (showPoint p) <> ", Text: " <> text

-- Last line in showShape function is commented out
```

If we try to compile the above, we get

![Imgur](https://i.imgur.com/yzywEzF.png)

Our old friend, the pattern match error appears. We have a partial function. And we already know how to solve these.(if not, refer pattern matching chapter)
