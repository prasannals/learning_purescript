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

#### Guards

Consider the gcd example used before. We could rewrite it using "guards" as

```
gcd :: Int -> Int -> Int
gcd n 0 = n
gcd 0 n = n
gcd n m | n > m = gcd (n - m) m
        | otherwise = gcd n (m - n)
```

A guard is just a boolean expression that needs to be evaluated before the function executes.

pattern match ----> guard check ----> execute corresponding expression

Syntax is as you see in the example. Put a "|" after the parameters and specify the guard condition after which we can specify what the function evaluates to.

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


## What else can we pattern match?

### Arrays

Examples
```
-- don't worry too much about "forall a.". We'll learn what that is soon.
isEmpty :: forall a. Array a -> Boolean
isEmpty [] = true  -- matches empty array
isEmpty _ = false  -- matches everything else

-- this function only multiplies the middle two numbers in an array of length 4
-- if the first and last number are both either 0 or 1
mulMid :: Array Int -> Int
mulMid [0, a, b, 0] = a * b
mulMid [1, a, b, 1] = a * b
mulMid _ = 0
```

* We can only match arrays of fixed length.
* No support for matching arrays of unspecified length.
* If the above feature is required, use Data.List

### Records

While discussing Type Synonyms, we came across the following code
```
type Product = {name :: String, category :: String, price :: Number}
type Order = {id :: Int, product :: Product}

orderStr :: Order -> String
orderStr order = (show order.id) <> ", " <> (productStr order.product)

productStr :: Product -> String
productStr product = product.name <> " : " <> product.category <> " : " <> (show $ product.price)
```

We could rewrite orderStr and productStr using pattern matching as shown below

```
productStr :: {name :: String, category :: String, price :: Number} -> String
productStr {name: n, category : c, price : p} = n <> " : " <> c <> " : " <> (show $ p)
```

{name :: String, category :: String, price :: Number} specifies that we're looking for a record with a name field that is a String, category field that is a String and a price that is a Number.

{name: n, category : c, price : p}  Here, we're telling purescript to bind the value of key "name" to local variable "n", bind value associated with key "category" to local variable "c". Finally, bind value associated with key "price" with local variable "p".

productStr :: {name :: String, category :: String, price :: Number} -> String

Here, we're saying that we accept records which have "name" , "category" and "price" fields. It shouldn't have fewer fields. Nor should it have more fields.

##### Row polymorphism

But if we only care about "name", "category" and "price" fields existing in a record and we don't mind other fields tagging along with "name", "category" and "price", in this case, we can use

```
productStr :: forall r. {name :: String, category :: String, price :: Number | r} -> String
productStr {name : n, category : c, price : p} = n <> " : " <> c <> " : " <> (show $ p)
```
We'll learn more about the "forall r." soon, and we will revisit this topic for a more detailed understanding. But for now, just use that syntax and know that what you're basically saying there is "I want name, category and price fields to be present in a record. They absolutely need to be present. But I don't mind having other fields along with them".


We can rewrite orderStr as follows
```
orderStr :: {id :: Int, product :: {name :: String, category :: String, price :: Number}} -> String
orderStr {id : id, product : {name : n, category : c, price : p}} = (show id) <> ", " <> (productStr {name : n, category : c, price : p})
```

We can add row polymorphism to orderStr as well

```
orderStr :: forall r0 r1. {id :: Int, product :: {name :: String, category :: String, price :: Number | r0} | r1} -> String
orderStr {id : id, product : {name : n, category : c, price : p}} = (show id) <> ", " <> (productStr {name : n, category : c, price : p})
```

Now we can call orderStr with any record as long as it contains fields id and product.

Notice how we had to write "productStr {name : n, category : c, price : p}". We had to do that because we didn't have the entire product record bound to a variable name.

#### Binding names to patterns

```
orderStr :: {id :: Int, product :: {name :: String, category :: String, price :: Number}} -> String
orderStr {id : id, product : prod@{name : n, category : c, price : p}} = (show id) <> ", " <> (productStr prod)
```

We used prod@pattern to bind the entire matched object to "prod" variable.

We could do the same even for the entire order

```
orderStr order@{id : id, product : prod@{name : n, category : c, price : p}} = (show id) <> ", " <> (productStr prod)

-- entire order is now bound to variable "order"
```

We could bind other patterns too, such as arrays

```
mulMid :: Array Int -> Int
mulMid arr@[0, a, b, 0] = a * b
mulMid arr@[1, a, b, 1] = a * b -- we can use whole array "arr" here. But... yeah... in our example, not much use of doing this.
mulMid arr@_ = 0
```
