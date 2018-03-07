## Data, Types and Kinds

This isn't by any means supposed to be a description of data, types and kinds in their general sense of meaning.

Rather, here, I'm trying to define "data", "type" and "kind" as they're used in PureScript.

### Data

Data is something that has a type. More concretely, when we pass in some data into the ":type " command in psci, we should get a type back.

```
:type 1         -- Int
:type 10.0      -- Number
:type "blah"    -- String
:type Just 1    -- Maybe Int
:type Nothing   -- forall t1. Maybe t1
:type Number    -- Doesn't work. Because Number is type, not data. data has type, types have kinds.
```

### Type

Type is something that has a kind. More concretely, when we pass in some type into the ":kind" command in psci, we should get back a kind.

```
:kind Number     -- Type
:kind Maybe      -- Type -> Type   because Maybe is defined as Maybe a = Just a | Nothing. It takes a type "a" and returns a type Maybe a
:kind Array      -- Type -> Type   again, array takes a type and gives an array of that type
```

##### Here is the confusing bit - There is a kind called "Type". All of the types that we usually use will have the kind "Type".

### Kind

Used to categorise types.
