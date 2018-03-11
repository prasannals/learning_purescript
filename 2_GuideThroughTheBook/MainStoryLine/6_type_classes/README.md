### Type Classes

To start off, let's look at some Java code in this PureScript course.
```
public int func(Object o){
  return o.doCalc() + 50;
}
```
The above code doesn't compile. Because Object "o" might or might not contain "doCalc" function.
Java simply doesn't have any way to know (in the above code) at compile time
that "o" definitely has "doCalc" function. Hence, we get a compile time error.

Similarly, consider the below code in PureScript
```
func :: forall a. a -> Int
func o = (doCalc o) + 50
```
In the above code,
* "a" can be any type.
* There is no information provided by the function declaration telling us that there is a "doCalc" function.
* There is no information provided to tell whether that doCalc function will work with "a"

Hence, the above code fails to compile.

Now, back to Java. If, instead, we had something like the following
```
interface DoingCalc{
  int doCalc();
}

//Somewhere else in some other class
//all imports and stuff  
public class SomeOtherClass{
  public void func(DoingCalc o){
    return o.doCalc() + 50;
  }
}
```
The above code would work perfectly well.
* We have created a new interface with the method "doCalc()"
* Since we're taking in "DoingCalc o" into "func", we add an additional constraint that any object passed into func should have implemented all methods in "DoingCalc" interface.
* Since we're sure that any object passed in has to have implemented the DoingCalc interface, we can use any method inside the DoingCalc interface inside func.

The equivalent way of specifying this in PureScript is -

```
-- This is a Type Class. Sorta like an interface.
class DoingCalc a where
  doCalc :: a -> Int

-- "DoingCalc a =>" is like saying "DoingCalc o" in Java. It is adding a constraint saying that
-- type "a" should have a implemented(have an instance of) the DoingCalc type class
func :: forall a. DoingCalc a => a -> Int
func o = (doCalc o) + 50
```
* "func" now gets compiled without a problem.
* We're allowed to use "doCalc" because "doCalc" is a function defined in "DoingCalc" type interface and for all "a", "a" type would have an instance of DoingCalc (or else data of such a type won't be allowed to be passed into the function)

### Syntax for defining a Type Class
```
class TypeClassName [zero or more quantified types] where
  -- list of functions
```

### Adding the type class constraint to functions
We use "TypeClass [zero or more quantified types] =>" syntax to specify constraints.

If there are multiple constraints, we specify them one after another as shown below
```
func :: forall a b c. SomeTClass a => OtherTClass b => a -> b -> c -> c
```
In the above example, we have two type class constraints, "a" has to have an instance of "SomeTClass" type class. "b" has to have an instance of "OtherTClass" type class.

### Defining instances of type classes

Defining an instance of "DoingCalc" for our Shape ADT.

```
instance shapeCalc :: DoingCalc Shape where
  doCalc :: Shape -> Int
  doCalc (Circle p radius) = 1
  doCalc (Rectangle p w h) = 2
  doCalc (Line p0 p1) = 3
  doCalc (Text p text) = 4
```

In general, syntax is
```
instance instanceName :: TypeClassName [one or more type for matching the quantified types] where
  -- implementation of the list of functions specified in the type class definition
```

### Common Type Classes

#### 1 . Show
```
-- | The `Show` type class represents those types which can be converted into
-- | a human-readable `String` representation.
class Show a where
  show :: a -> String
```
You might have come across a situation where you evaluate some expression in psci and get an error telling you that there is no Show instance for your type. psci tries to use "show" function in the Show type class to get the string representation of the type you pass in in order to display it on the terminal. Hence, if you haven't defined a show instance for your type but try to print it on psci, we get an error.

Defining a Show instance for our Point and Shape class
```
instance showPoint :: Show Point where
  show :: Point -> String
  show (Point {x, y}) = "Point : x=" <> (show x) <> ", y=" <> (show y)

instance showShape :: Show Shape where
    show :: Shape -> String
    show (Circle p@(Point {x,y}) radius) = "Circle, " <> (show p) <> " , radius=" <> (show radius)
    show (Rectangle p@(Point {x,y}) w h) = "Rectangle, " <> (show p) <> ", width=" <> (show w) <> ", height=" <> (show h)
    show (Line p0@(Point {x:x0, y:y0}) p1@(Point {x:x1, y:y1})) = "Line, " <> (show p0) <> ", " <> (show p1)
    show (Text p@(Point {x,y}) text) = "Text, " <> (show p) <> ", Text: " <> text
```
Observe how we're using "(show p)" in our showShape function. We're calling the show function on the Point ADT. Since we've defined a Show instance for Point, it works as expected.

#### 2 . Eq

Eq instances are used to define equality.

```
class Eq a where
  eq :: a -> a -> Boolean

-- "==" operator is simply an alias for "eq" function
```

Defining Eq instances for Point and Shape
```
instance pointEq :: Eq Point where
  eq :: Point -> Point -> Boolean
  eq (Point {x:x0, y:y0}) (Point {x:x1, y:y1}) = (x0 == x1) && (y0 == y1)

instance shapeEq :: Eq Shape where
  eq :: Shape -> Shape -> Boolean
  eq (Circle p0 radius0) (Circle p1 radius1) = (p0 == p1) && (radius0 == radius1)
  eq (Rectangle p0 w0 h0) (Rectangle p1 w1 h1) = (p0 == p1) && (w0 == w1) && (h0 == h1)
  eq (Line p00 p01) (Line p10 p11) = (p00 == p10) && (p01 == p11)
  eq (Text p0 text0) (Text p1 text1) = (p0 == p1) && (text0 == text1)
  eq _ _ = false
```
Observe that we're using (p0 == p1) in eq for Shape. This works because Eq instance for Point is defined.

#### 3 . Ord

Ord type class is used to specify the ordering. ">" , "<" , ">=" , "<=" operators are defined using "compare" function defined in Ord.

```
data Ordering = LT | EQ | GT

class Eq a <= Ord a where
  compare :: a -> a -> Ordering

-- NOTE : Ordering is with respect to the FIRST argument
-- if the first argument is less than the second, we return LT
-- if the first argument is greater than the second, we return GT
-- if both arguments are equal, we return EQ
```
#### Quick detour - Superclasses
Observer "Eq a <= Ord a". "Eq a <=" is used to specify the constraint that there needs to be an Eq instance defined for "a" before an Ord instance can be defined for it. For every instance of Ord a there must be an Eq a instance defined. Eq a is called the superclass of Ord a. Ord a is the subclass of Eq a.

![Imgur](https://i.imgur.com/M18W98T.jpg)

Defining an Ord instance for Point. Let's just have a simple rule saying that a Point is greater than another point if it's x axis is greater.

```
instance pointOrd :: Ord Point where
  compare :: Point -> Point -> Ordering
  compare p0@(Point {x:x0, y:y0}) p1@(Point {x:x1, y:y1}) = if p0 == p1
                                                               then EQ
                                                               else if x0 > x1
                                                                        then GT
                                                                        else LT
```
In psci, we type the following
```
> p0 = Point {x: 100.0, y : 50.0}
> p1 = Point {x: 150.0, y : 40.0}
> p0 > p1
false
> p1 > p0
true
```

#### 4 . Semiring - add, mul

Semiring class is defined for types which support addition and multiplication.

```
class Semiring a where
  add  :: a -> a -> a   -- operator + is an alias for add
  zero :: a             -- a + zero = a  should be satisfied
  mul  :: a -> a -> a   -- operator * is an alias for mul
  one  :: a             -- a * one  = a  should be satisfied
```

Try the following in psci
```
> addMe first second = first + second
> :type addMe
forall a. Semiring a => a -> a -> a
```
Few things to observe :
* Semiring instance is required on type "a". This is because we're using "+" i.e. "add" function which is in Semiring type class.
* add, mul are performed on arguments of the same type

Defining Semiring instance for Point

```
instance semiringPoint :: Semiring Point where
  add :: Point -> Point -> Point
  add (Point {x:x0, y:y0}) (Point {x:x1, y:y1}) = Point {x : (x0 + x1), y : (y0 + y1)}

  zero :: Point
  zero = Point {x:0.0, y:0.0}

  one :: Point
  one = Point {x:1.0, y:1.0}

  mul :: Point -> Point -> Point
  mul (Point {x:x0, y:y0}) (Point {x:x1, y:y1}) = Point {x : (x0 * x1), y : (y0 * y1)}
```

#### 5. Semigroup and Monoid

Semigroup is used to define "append" operation. "<>" operator is an alias for the "append" function.

```
class Semigroup a where
  append :: a -> a -> a
```
* append takes two parameters of the some type and returns the same type

Defining append for Point (NOTE: I'm not even sure what append should be like for Point. I've just defined it as addition just for the purpose of seeing how to define an instance for Semigroup)

```
instance semigroupPoint :: Semigroup Point where
  append :: Point -> Point -> Point
  append first second = first + second
```

#### Monoid
Monoid is very similar to Semigroup except that it defines an "empty value" for a type.

```
class Semigroup m <= Monoid m where
  mempty :: m
```

We can see from the type class definition of Monoid that Monoid is a subclass of Semigroup. Hence for all "a", "a" will also have "append" function defined. We're just adding "mempty" functionality also in Monoid class.

Defining Monoid instance for Point. Let's just say that a point at (0.0, 0.0) is "empty" (Er.. yeah.. it might not make sense. Just defining it so that we get to practice defining more instances of different type classes)

```
instance monoidPoint :: Monoid Point where
  mempty :: Point
  mempty = Point {x:0.0, y:0.0}
```


### Type Annotations

![Imgur](https://i.imgur.com/57pVqoX.jpg)

### Overlapping instances

In a nutshell, if we have multiple definitions of the same type class for the same types -
* Code still compiles without warnings (if no call is made to the functions within the type class).
* But when we call functions within the type class, compiler tries to find the correct instance and this results in a warning.

Example
```
instance sCalc :: DoingCalc Shape where
  doCalc :: Shape -> Int
  doCalc (Circle p radius) = 1
  doCalc (Rectangle p w h) = 2
  doCalc (Line p0 p1) = 5
  doCalc (Text p text) = 4


instance shapeCalc :: DoingCalc Shape where
  doCalc :: Shape -> Int
  doCalc (Circle p radius) = 1
  doCalc (Rectangle p w h) = 2
  doCalc (Line p0 p1) = 3
  doCalc (Text p text) = 4

main = log "Hello Sailor"
```
If we compile the above code, we get no errors or warnings. But if we change the main function to use "doCalc",
```
main = log $ show $ doCalc anotherShape
```
![Imgur](https://i.imgur.com/OP8rKgb.png)

### Instance Dependencies

This is how to add constraints to type class instances.

![Imgur](https://i.imgur.com/LUBL4cT.jpg)

![Imgur](https://i.imgur.com/5st3eIj.jpg)

### Multi Parameter Type Classes
There can be multiple quantified types in a type class as shown below

```
class Stream stream element where
  uncons :: stream -> Maybe { head :: element, tail :: stream }

instance streamArray :: Stream (Array a) a where
  uncons = Array.uncons

instance streamString :: Stream String Char where
  uncons = String.uncons
```

### Functional Dependencies

Multi parameter type classes can cause complications with type inference.

Using the above defined "uncons" function,
```
genericTail xs = map _.tail (uncons xs)
```
We pass "xs" to "uncons". Type of "xs" can help resolve the type of "stream"(see above "Stream" type class). Type of "element" is still a total mystery to the compiler.

Let's take the example when "xs" is a String. "stream" will be String. But "element" can be anything. We know that "element" is a Char. But the compiler doesn't have any clues to infer that.

We can add a "functional dependency" to Stream class as shown below
```
class Stream stream element | stream -> element where
  uncons :: stream -> Maybe { head :: element, tail :: stream }
```
"stream element | stream -> element" this part tells the compiler that whatever "stream" is, it'll have a unique mapping to "element" type. This is enough information for the compiler to let the code compile.

### Nullary type classes

* We can even define type classes with zero arguments. These are called "Nullary Type Classes".
* "Partial" is an example for Nullary type class
* These type classes can be thought of as "labels" used to mark certain functions. When we add "Partial" constraint to a function, we're just marking the function and assuring the compiler that we're aware of what we're doing and to let this code compile even if it might end up crashing at runtime.
