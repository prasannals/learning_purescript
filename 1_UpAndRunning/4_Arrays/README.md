## Arrays

### Before startimg, add the following libraries using bower
```
bower install purescript-arrays
```

### Creating an Array
```
ar = [1,2,3,4] -- similar to array creation in python, javascript
-- BUT
anotherAr = [1,2,"st", "blah"] -- NOT VALID
-- Arrays should contain contents of the SAME TYPE
-- Similar to arrays in C, C++ in this regard
```

### Accessing array elements
```
ar = [1,2,3]
-- Array indexing starts from 0
-- We use the "!!" operator to access elements using their index
ele = (ar !! 0)
```

#### What is "ele" now? It Maybe an Int.
### Small detour - Maybe type
```
-- Accessing the array elements returns a "Maybe" type.
-- Taking our previous example
ar = [1,2,3]
ele = (ar !! 0) -- "ele" is of type "Maybe Int"
-- Maybe types are needed in purescript because of the lack of "null" and "undefined"
-- Functions are Pure Functions. But.... we won't get into the details of that here.
-- (Maybe Int) can either contain the value "Nothing" or it can contain (Just Int)
-- Similarly (Maybe String) can either contain the value "Nothing" or it can contain a (Just String)
-- and so on

-- If we try to access an element from a non existant index, we get "Nothing"
-- Else our Maybe will contain the value at the required index
```
#### So.... how do I take the "Int" out of the "Just Int"?
```
ar = [1,2,3]
ele = (ar !! 0) -- "ele" is of type "Maybe Int"
import Data.Maybe (fromMaybe)
-- fromMaybe syntax
-- fromMaybe defaultValue (Maybe Value)
-- fromMaybe returns the Value inside Maybe if the value exists
-- fromMaybe returns the defaultValue if (Maybe Value) contains the value "Nothing"

val0 = fromMaybe 0 (ar !! 0)  -- val0 now contains 1
val1 = fromMaybe 0 (ar !! 1)  -- val1 now contains 2
-- and so on

valNo = fromMaybe 0 (ar !! -1) -- -1 is not a valid index. so, defaultValue is returned.
-- valNo contains 0 since 0 is the defaultValue
```

fromMaybe documentation - https://pursuit.purescript.org/packages/purescript-maybe/3.0.0/docs/Data.Maybe#v:fromMaybe


### Adding elements to an Array
```
-- We can use the "<>" operator
["hey", "this"] <> ["is", "concat"] -- gives ["hey", "this", "is", "concat"]

-- REMEMBER: both sides of "<>" operator should be a list.
-- If you're adding a single element, put that element in a list and append it
li = [1,2,3]
liNew = li <> [4]   -- liNew is [1,2,3,4]
newLi = [0] <> li  -- newLi is [0,1,2,3]
```

### Some useful array functions
Source - https://learnxinyminutes.com/docs/purescript/

```
-- head returns the first element inside a Maybe context (use fromMaybe to get rid of Maybe)
head [1, 2, 3, 4] -- Just (1)
-- last returns the last element inside a Maybe context
last [1, 2, 3, 4] -- Just (4)
-- tail returns all elements except the first element as a Maybe Array
tail [1, 2, 3, 4] -- Just ([2,3,4])
-- init returns all elements except the last element as a Maybe Array
init [1, 2, 3, 4] -- Just ([1,2,3])

-- ".." operator creates a list from the LHS to the RHS both inclusive
1..4 -- [1, 2, 3, 4]
length [1, 2, 3, 4] -- 4  length returns the length of the array
drop 3 [1, 2, 3, 4] -- [4]  drop drops the first 3(in this example) elements
take 3 [1, 2, 3, 4] -- [1, 2, 3]  take retains only the first 3 elements (in this example)
append [1,2,3] [4,5] -- [1,2,3,4,5]
```

### Arrays are immutable (as is the case with almost everything else in PS)
