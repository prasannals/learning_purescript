## Looping in PureScript (Recursion)

### In PureScript, we don't have "for" loops or "while" loops
We don't have the usual looping structures such as for and while loops. In fact, we don't have any looping structure that is built into the language. There are hacky ways to loop. But we don't need to rely on that.

### BIG IDEA - Any loop can be represented as a recursive function
Yes. All your for loops and while loops and while loops can be written as recursive functions.

* First, we will show that all FOR loops can be written as WHILE loops.
* Next, we will see how to represent while loops as recursive functions.

#### Let's take an example
```
// In JavaScript
// We add all numbers in an array using a for loop
var arr = [1,2,3,4];
var sum = 0;
for(var i = 0; i < arr.length; i++){
  sum = sum + arr[i];
}
```
```
// In JavaScript
// We add all numbers in a 2D array using a for loop
var arr = [[1,2,3,4], [1,2,3,4]];
var sum = 0;
for(var i = 0; i < arr.length; i++){
  for(var j = 0; j < arr[i].length; j++)
    sum = sum + arr[i][j];
}
```

#### Lets write both of these as recursive functions
#### But before that

#### 1. All for loops can be written as while loops
Structure of a for loop can be seen as
```
for(initialization; condition; updates){
  //statements
}
```
The exact same logic can be written using while loops as
```
initialization;
while(condition){
  //statements

  updates;
}
```
Hence, we need only learn how to convert while loops into recursive functions to learn how to represent any loop as a recursive function.

#### 2. Writing while loops as recursive functions

Let's analyse a while loop

![](https://i.imgur.com/LVBwAQ2.png)

![](https://i.imgur.com/1jm92I5.png)

#### Guidelines for writing a while loop as a recursive function
1. Insert all "loop variables" into the function arguments.
2. Variables which are outside the while loop block which are getting modified inside the while loop, such variables should also be put inside the function arguments.
3. Variables which have block level scope can be replaced with an expression or another function which evaluates to the same.
4. return statements and break statements are nothing but the "base case"(exit condition) in a recursive function.
5. continue statements are nothing but recursive calls where only the "loop variables" are updated and all other arguments are kept the same.

#### Tail Recursion

What happens if your loop is executing for a long time? The recursive calls keep getting made. Doesn't this lead to stack overflow?!

This problem is what the Tail Recursion Optimisation solves.

Let's first understand when functions are in "tail recursive position".
##### NOT tail recursive
```
fact n = if n == 0
          then 1
          else (n * (fact (n - 1)))
```
In the above example, once the recursive fact call returns, n is multiplied with it. Hence, the stack has to maintain "n"s value. Therefore, individual stack records have to be maintained for each recursive call. Stack overflow can occur.

##### Tail recursive
```
fact n acc = if n == 0
              then acc
              else fact (n - 1) (acc * n)
```
In this example, once the recursive call returns, no other operation is being performed. The recursive call itself is the last operation performed before the function returns. Hence, no information needs to be maintained in the calling functions stack. In this case, the recursive call can simply be replaced with a jump to the first line of the function.

Stack frame is not allocated for recursive calls. Hence, stack overflow can be avoided.
