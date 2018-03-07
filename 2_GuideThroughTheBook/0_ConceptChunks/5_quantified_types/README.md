### Quantified Types

Yep. We're finally here. We'll finally understand the mysterious "forall a b c d." stuff.

Let's start, as usual, by considering a simple example.

```
addToArr :: forall a. Array a -> a -> Array a
addToArr arr ele = arr <> [ele]
```

In the first line, what we're saying is "Let a be any type. For any type a, the first parameter should be an Array of that type a. Second parameter should be of type a. We then return an array of type a"

Here, "a" can be any type(recall our previous discussion about types).

Another example

```
f1 :: forall a. a -> a
f1 ele = ele
```

The above example works perfectly fine. It just returns whatever is passed in. Nothing interesting. If we pass in an Int, we get back an Int, if we pass in a Number, we get back a Number.

Here something to think about - if the function is supposed to, say, take in an Int and return an Int, why didn't I do something more interesting like adding a number to the element?

Could we do
```
f1 :: forall a. a -> a
f1 ele = ele + 10
```

What if I pass in a String? What is a String + 10? What does that even mean? What does "+" even mean for each type?

For now, firstly, the above example is wrong. Because "a" can be any type. Including ADTs that we create. Shape + 10 or Console + 10 might not mean anything. We need to define what "+" means for each type. We'll learn how to do it when we learn about Type Classes.

Also, how do we say something like "Only take those types where "+" has a proper defined meaning and add "ele" to it"? (we're not adding 10 because addition with Int might not be defined for every type) We'll learn how to specify this, again, when we learn Type Classes.

#### Here's the problem - it's difficult to come up with practical useful examples which use quantified types but don't use type class constraints.
The types will be too general without the constraints and we will be resticted to doing very general stuff. We will revisit quantified types once we learn Type Classes.

### For now, the summary is that whenever we use quantified types, say, "a", "a" can be any type.

We will learn Type Classes first and then revisit quantified types to learn about it more detail.
