## Type Synonyms

### What is a type synonym?
We could think of it as a simple way of creating a custom data type(not completely right. Read on.)

### How do we create a type synonym?
~~~purescript
type NameOfType = {nameOfVar1 :: String, nameOfVar2 :: Int}

type Product = {name :: String, category :: String, price :: Number}

type Order = {id :: Int, product :: Product}
~~~
In general

type NameOfType = {varName :: Type, varName :: Type and so on}

### How do we create an instance of a type synonym?

~~~purescript
myProduct :: Product
myProduct = {name : "Galaxy S9", category : "SmartPhones", price : 60000.0}

myOrder :: Order
myOrder = {id : 1, product : myProduct}
~~~
Basically, {varName : value, varName : value and so on}

Make sure that the "varName" matches the name you had used while defining the type synonym and that the value matches the value specified in the declaration.

### How do we use a type synonym?

Pretty much the same as how you'd use a Record.

~~~purescript
productStr :: Product -> String
productStr product = product.name <> " : " <> product.category <> " : " <> (show $ product.price)
~~~
Use the "." (dot) syntax to access the elements inside the record.

### But the type synonyms aren't limited to just records. What else can we define it as?

type Name = type

"type" here can be any type that can be in a function declaration.

~~~purescript
type a = Int -- actually INVALID. Because type names should always start with a capital letter

type AType = Int -- valid
type BType = Number -- valid
type CType = (Array (Array Int)) -- valid
~~~
Since Int, Number, (Array (Array Int)) can be types in a function parameter, they can also be used here.

Let's now say you had a function

~~~purescript
showAType :: AType -> String
showAType aType = (show aType)  -- treat "aType" just as you would treat an Int

-- Similarly, treat bType just as you'd treat a Number
-- CType just as you'd treat an (Array (Array Int))
~~~

### Detour - "show" function
For now, just think of "show" function as a "toString" function. It just converts Int, Number, Arrays to String. It basically converts whatever you pass in into a string. (sometimes, it doesn't know how to do this. Example, user defined types. In these case, we have to define the show "instances" but we'll get to that in the later chapters)
