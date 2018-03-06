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
