## Pure vs Impure Functions

### Concept of a Pure Function

Pure Function is a function which depends only on its input parameters. A function whose only defining characteristics are its input and output. This means
* It does NOT depend on any external state.
* It always produces the same output for a given input.
* It does NOT cause side effects.

For More Info :

https://www.sitepoint.com/functional-programming-pure-functions/
https://medium.com/@jamesjefferyuk/javascript-what-are-pure-functions-4d4d5392d49c


#### Every function in PureScript has to be a pure function!

In other languages, we might have something like "random()" which returns a random number. But the random function depends on external parameters. It also gives different outputs for the same input. Hence, it is NOT a pure function.

Does this mean that PureScript doesn't have random number generation?!

### Clever trick - wrap the uncertainty inside certainty

If we had a random function signature as
```
random :: Number
```
certainly, it would be impossible to have it inside PureScript as the function won't be a pure function (since "random" is intended to return a random value each time.same input gives different output)

But we can get around this limitation by wrapping the Number in another type.
```
random :: forall e. Eff (random :: RANDOM | e) Number
```
Now, we're returning something of type "Eff" which contains a Number inside it(don't worry about the syntax too much if you don't understand it. We cover Eff in our MainStoryLine). And we always return the same type no matter what Number gets generated. Hence, the pure function criteria is met. Yeah... kinda feels hacky. But it gets the job done.
