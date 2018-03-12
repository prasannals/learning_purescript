### Basic Types and Assignments

#### Assignment

```
-- "varName = val is how you assign values"
a = 10 -- variable "a" contains the value "10"
-- BUT you're NOT allowed to modify the value of a variable once you assign a value to it
-- So, the following statement will be INVALID
a = 12 -- cant do this because we've already said "a = 10"
aa = 12 -- this is totally okay though
```

#### Int
```
-- Any numerical literal with no decimal point is an int
a = 1 -- "a" is an int
b = 10000 -- another int

import Prelude -- contains "+" function
c = a + b -- Int + Int gives another Int
d = a - b -- d is also an Int
e = a / b -- e is an int. Int / Int gives truncating division
```

#### Number
```
-- Any numerical literal with a decimal point is a Number
a = 1.0 -- "a" is a Number
b = 1000.0 -- another Number

import Prelude
c = a + b -- Number + Number gives Number
d = a - b -- Number - Number -> Number
e = a / b -- Number / Number -> Number

import Math
f = a % b
-- % operator in "purescript-math" library expects both arguments to be Number type
```

#### String
```
s = "hello, world" -- s is a string

anotherStr = "hello, " <> "world" -- <> is used for string concatenation

s == anotherStr -- returns "true"
s /= anotherStr -- returns "false" . "/=" is the "not equals" operator.

```

#### Boolean

```
a = true -- a is true
b = false -- b is false
```

#### Char
```
ch = 'a'  -- "":type ch" will return Char
```
