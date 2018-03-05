## Calling PureScript code from JavaScript


#### To compile PureScript code to JavaScript, use
```
pulp build --to file.js
```

In the compiled JavaScript code, PS["Main"] contains all your functions.

REMEMBER - Functions in PureScript are curried functions.

Let's take the example of the factorial function that we saw last time

```
fact :: Int -> Int -> Int
fact n acc = if n == 0
              then acc
              else fact (n - 1) (acc * n)
```
Once compiled to JavaScript, we can call the "fact" function like so
```
// In JS
PS["Main"].fact(4)(1); // to calculate the factorial of 4
```
