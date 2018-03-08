## Functions As Operators - infix, infixl, infixr

We can defined functions as operators i.e. we can assign operators for functions.

infix, infixl, infixr can be used to give an alias to a function. infixl specifies that the operator is left associative. infixr specfied that the operator is right associative.

General Syntax
```
infixl PRECEDENCE FUNCTION as OPERATOR
```
where PRECEDENCE is an integer. Low number means less priority. High number means high priority. High priority operators get evaluated earlier than low priority operators.

Example
```
infixr 0 apply as $
```

#### Quick Detour - $
$ is just an alias for a regular function called "apply".
```
apply :: forall a b. (a -> b) -> a -> b
apply func x = func x
```
apply just... applies the passed in function.... yeah.

But when we define "$" as a 0 precedence operator, interesting functionalities emerge. Since the precedence is so low and it is right associative, evaluation happens from right to left. We can replace parentheses with $ in many situations.

Example
```
show (func1 a (func2 b))
-- can be rewritten as
show $ func1 a $ func2 b
```

### Let's define our own operator - the "~~" operator

We have a function
```
doCalc :: Int -> Int -> Int
doCalc first second = (first * first) + (second * second)
```
Now we define our operator
```
infixl 8 doCalc as ~~
```
We can use the operator as shown below
```
2 ~~ 3  -- evaluates to 13
```
