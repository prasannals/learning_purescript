## Lambda Expressions

Lambda expressions can be used to create in line functions.

Suppose we have a function as shown below
```
func :: forall a b. (a -> b -> b) -> a -> b -> b
func anotherFunc d1 d2 = anotherFunc d1 d2
```
I admit, it might not be the most useful function around. Or even the best way to write that function, but for learning purposes, it will suffice.

In this function, we have two quantified types "a" and "b". First parameter to the function is a function which takes "a" "b" and returns a "b". Second parameter is of type "a". Third is of type "b" and we return something of type "b".

Inside the function, we're just applying the passed in function and returning whatever it evaluates to.

* Option 1

We could create a function which we want to pass in using regular function creation syntax that we know and love.

```
doCalc :: Int -> String -> String
doCalc i s = s <> (show i)
```

We could then pass in "doCalc" into "func"

```
func doCalc 1 "blah" -- evaluates to "blah1"
```

* Option 2

We could use the hero of our mini story - lambda expressions! We can create anonymous functions inline using lambda expressions.

```
func (\i s -> s <> (show i)) 1 "blah" -- evaluates to "blah1"
```

* We create lambda expressions using "\" syntax. Immediately after "\" we specify the arguments. After "->", we tell the expression that the function evaluates to.
* Instead of "=", we use "->"
* Types are automatically inferred to be the most general type. (In our case, forall a. Show a => a -> String -> String)
* Lambda expressions can be assigned to labels
```
myAwesomeFunc = (\first second -> (first + (first * second)))
```
