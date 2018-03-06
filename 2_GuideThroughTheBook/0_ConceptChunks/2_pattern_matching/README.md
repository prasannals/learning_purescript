## Pattern Matching

In pattern matching,
* we specify specific values for which specific actions need to be taken.
* The "cases" are tried from first till last. The first matching condition causes the function to evaluate the corresponding expression and return the result.

Let's look at a few examples

```
sumTillN :: Int -> Int
sumTillN 1 = 1   --  if first parameter is 1, return 1
sumTillN n = n + (sumTillN (n - 1)) -- if anything else, bind value to variable "n" and return (n + sumTillN (n - 1))

handleCases :: Int -> String
handleCases 0 = "0! That doesn't look good!" -- if parameter is 0, return this string
handleCases 1 = "1. That's better." -- if parameter is 1, return this string
handleCases n = "Anything other than 0 and 1. Much better!"
-- we only get to the third case if first two fail, so if not 0 and 1, bind value to "n" and return the corresponding string


-- previous function could also be written as

handleCases :: Int -> String
handleCases 0 = "0! That doesn't look good!" -- if parameter is 0, return this string
handleCases 1 = "1. That's better." -- if parameter is 1, return this string
handleCases _ = "Anything other than 0 and 1. Much better!"
-- we only get to the third case if first two fail, so if not 0 and 1, just return the corresponding string
-- "_" means anything else. its like a wildcard. gets matched with anything.
-- since the cases are evaluated in the order that we specify them, and since
-- we specify "_" in the last case, the corresponding expression will be
-- evaluated if every other condition fails


gcd :: Int -> Int -> Int
gcd n 0 = n -- can specify a few pages as patterns (i.e. 0 in this case)
            -- other variables can be bound to names (i.e. "n" in this case)
gcd 0 m = m
gcd n m = if n > m
            then gcd (n - m) m
            else gcd n (m - n)

parseBool :: String -> Boolean
parseBool "true" = true
parseBool "TRUE" = true
parseBool _ = false  
```

* We can pattern match on Booleans, Chars, Numbers, Arrays and Records as well

#### Case Expressions

Do we HAVE to specify a function every time we want to use pattern matching? Not necessarily.

We can instead use case expressions.

```
general syntax

case expression of
  pattern1 -> expression1
  pattern2 -> expression2
  ..
  patternn -> expressionn
```

Example:
```
sumTillN :: Int -> Int
sumTillN n = case n of
              1 -> 1
              anythingElse -> anythingElse + (sumTillN (n - 1))

-- can also be written as
sumTillN :: Int -> Int
sumTillN n = case n of
              1 -> 1
              _ -> n + (sumTillN (n - 1)) 
```

#### Partial Functions

Consider the below function
```
pat :: Number -> String
pat 0.25 = "quarter"
pat 0.5 = "half"
pat 1.0 = "full"
```
If we call (pat 1.0) we get "full", if we call (pat 0.5), we get "half". But what if we call (pat 1.25)? What then? Er.... 1.0 is pretty close to it... so.... "full"? Our program simply won't know what to do. Hence, these sorts of functions will result in a compile time error. Functions which return a value for any input are called total functions, functions which
do not are called partial functions.

We get the following error

```
A case expression could not be determined to cover all inputs.
The following additional cases are required to cover all inputs:

  _

Alternatively, add a Partial constraint to the type of the enclosing value.
```

The compiler itself is telling us how to solve the error

* Option 1 - Add the " _ " case
```
pat :: Number -> String
pat 0.25 = "quarter"
pat 0.5 = "half"
pat 1.0 = "full"
pat _ = "Not sure" -- our program now knows what to do for all inputs
```
* Option 2 - Add the "Partial" constraint.
```
-- "=>" syntax is used to add Type Class constraints. We'll learn more about these in other lessons. For now, just use this syntax. Basically, it adds some constraint to the function.
pat :: Partial => Number -> String
pat 0.25 = "quarter"
pat 0.5 = "half"
pat 1.0 = "full"
```
Now, the function will compile without error. But to call it
    * install purescript-partial. Use "bower install purescript-partial --save"
    * import Partial.Unsafe (unsafePartial)
    * Call the function as  "unsafePartial (pat 1.0)" or whatever other value you want to pass into the function
    * The function returns expected values for specified patterns.
    * BUT if we get a value which isn't specified, we get a runtime error! Yikes! REMEMBER - use unsafePartial with caution! We don't want runtime errors!

TIP : Use Maybe type to return "Nothing" in cases where you're unsure what your function should return.
