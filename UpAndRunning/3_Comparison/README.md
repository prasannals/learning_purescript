## Comparison, Logical Operators and if then else

### Comparison operators

```
--    ==    Equality testing
1 == 2 -- use "==" for equality testing
"somestr" == "somestr" -- true

--    /=    Not equal to (similar to "!=" in many popular languages)
1 /= 2  -- true

--    >=    Greater than or equal to
1 >= 2 -- false

--    <=    Less than or equal to
1 <= 2  -- true

--    <     Less than
--    >     Greater than

```
### Logical Operators
```
--    not     "not" is used for negation

not true -- gives false
not (1 < 2) -- gives false. (1 < 2) is true. not true is false


--    &&       "&&" is the logical AND operator
--    ||       "||" is the logical OR operator

(1 == 1) && (2 == 2)
(1 == 1) || (2 == 2)

```
### if then else expressions
```
-- if then else expressions can be used for conditional execution of code
-- Syntax :
-- if booleanExpression then expr1 else expr2

a = if (1 < 2) then 1 else 2  

-- nesting if else
if (1 < 2) then (if (2 > 1) then 1 else 0) else 4

-- NOTE: the condition has to be something that evaluates to a Boolean
-- "if 1 then true else false" would be invalid because 1 is not a Boolean

```
