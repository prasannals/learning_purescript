## Functors, Applicatives and Monads

The approach we will take is learning each of these by looking at their type class definitions.

### Before getting started - have a look at MiniAdventure "PureImpure"

### Functors

```
class Functor f where
  map :: forall a b. (a -> b) -> f a -> f b
```
Functors basically transform something of type "f a" to "f b". They convert "a" to "b" by using the function passed as the first parameter.

Each type "f" defines how mapping is done from "f a" to "f b" by defining a Functor instance. For example, Arrays define that mapping over Array of type a to Array of type b means that every element in the array is mapped from type a to b and the new Array of type b is returned.

![Imgur](https://i.imgur.com/S0erqY1.jpg)

<$> is an alias for map function.

Example
```
map (\i -> (show i)) [1,2,3]
```
is the same as
```
(\i -> (show i)) <$> [1,2,3]
```

Case Study - Functor instance of Maybe type
```
instance functorMaybe :: Functor Maybe where
  map fn (Just x) = Just (fn x)
  map _  _        = Nothing
```
