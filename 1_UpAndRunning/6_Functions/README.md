## Functions

### Example
```
add :: Int -> Int -> Int
add first second = first + second
```
### Function Declaration
This gives information about the function parameters(inputs) and the function return type
```
add :: Int -> Int -> Int  -- This line is the function Declaration
-- :: starts the declaration
-- Int -> Int -> Int   
-- The last among the above series of types will be the return type.
-- Rest will be parameter types separated by "->"
-- here, the first parameter is an Int
-- second parameter is also an Int
```

### Function Definition
This defines what the function evaluates to(what the function does, basically)
```
add first second = first + second -- This line is the Definition

-- "first" and "second" are function parameters
-- Function parameters need to be separated with space
-- after "=" , we specify what the function evaluates to
-- in our case, it evaluates to the expression "first + second"

-- Functions evaluate to a single expression in purescript!
-- Might seem restrictive but its not really too restrictive once you learn how to
-- use functors, applicatives and monads. We'll get there.
```

### Calling a Function
```
add 1 2 -- equivalent to add(1, 2) in most other "popular" languages
-- we call a function by specifying the function name and providing its arguments
-- The arguments should be separated by spaces
```

### Taking other functions as parameters in a function
```
myCalc :: Int -> Int -> Int
myCalc a b = (a + b) + (a - (b * b) )

doCalc :: (Int -> Int -> Int) -> Int -> Int -> Int
doCalc func a b = ( (a * a) - (func a b) ) * b

-- (Int -> Int -> Int) specifies that the function takes a function which has
-- two int arguments and returns another int
```

### Function declaration too hard to type? Well, you don't have to type it.

If no function declaration is provided, PureScript automatically infers the most general type by looking at the calculation being done.

```
add a b = a + b -- also totally valid. no function declaration specified
```

### Another Example

```
-- Another Example
-- isLenEq returns true if length of array (first parameter) is equal to the second parameter
isLenEq :: (Array Int) -> Int -> Boolean  -- Declaration
isLenEq arr num = ((length arr) == num)  -- Definition

-- We can call the function as shown below
ar = [1,2,3]
isLenEq ar 3 -- returns true
isLenEq ar 4 -- returns false
```


### Curried Functions

In PureScript, every single function takes only a single argument. Yep. Even the "add" function that we defined earlier.

"But it clearly takes two parameters. Look at it!". I know. I know. I've been lying to you.... sorta. Let's glimpse into what's actually happening in add function \*\*drumrolls\*\*

```
add 1 2
-- add is a function which takes a single argument
-- ..... and it returns another function which takes the next argument

(add 1) 2 -- this is what is happening behind the scenes
-- (add 1) returns a function which takes another parameter
-- we pass 2 to that newly returned function.

-- All this happens behind the scenes. As far as you're concerned, add takes
-- two parameters and returns their sum.
```
But there are advantages to currying functions.
* We can create "specialized" functions. Instead of having a function which adds two numbers, we can specialize it, say, to add 3 to any number passed in.
* We can pass in parameters as "contextual information"
