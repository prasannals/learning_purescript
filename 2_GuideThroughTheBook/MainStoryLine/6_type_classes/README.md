### Type Classes

To start off, let's look at some Java code in this PureScript course.
```
public int func(Object o){
  return o.doCalc() + 50;
}
```
The above code doesn't compile. Because Object "o" might or might not contain "doCalc" function.
Java simply doesn't have any way to know (in the above code) at compile time
that "o" definitely has "doCalc" function. Hence, we get a compile time error.

Similarly, consider the below code in PureScript
```
func :: forall a. a -> Int
func o = (doCalc o) + 50
```
In the above code,
* "a" can be any type.
* There is no information provided by the function declaration telling us that there is a "doCalc" function.
* There is no information provided to tell whether that doCalc function will work with "a"

Hence, the above code fails to compile.

Now, back to Java. If, instead, we had something like the following
```
interface DoingCalc{
  int doCalc();
}

//Somewhere else in some other class
//all imports and stuff  
public class SomeOtherClass{
  public void func(DoingCalc o){
    return o.doCalc() + 50;
  }
}
```
The above code would work perfectly well.
* We have created a new interface with the method "doCalc()"
* Since we're taking in "DoingCalc o" into "func", we add an additional constraint that any object passed into func should have implemented all methods in "DoingCalc" interface.
* Since we're sure that any object passed in has to have implemented the DoingCalc interface, we can use any method inside the DoingCalc interface inside func.

The equivalent way of specifying this in PureScript is -

```
-- This is a Type Class. Sorta like an interface.
class DoingCalc a where
  doCalc :: a -> Int

-- "DoingCalc a =>" is like saying "DoingCalc o" in Java. It is adding a constraint saying that
-- type "a" should have a implemented(have an instance of) the DoingCalc type class
func :: forall a. DoingCalc a => a -> Int
func o = (doCalc o) + 50
```
* "func" now gets compiled without a problem.
* We're allowed to use "doCalc" because "doCalc" is a function defined in "DoingCalc" type interface and for all "a", "a" type would have an instance of DoingCalc (or else data of such a type won't be allowed to be passed into the function)

### Syntax for defining a Type Class
```
class TypeClassName [zero or more quantified types] where
  -- list of functions
```

### Adding the type class constraint to functions
We use "TypeClass [zero or more quantified types] =>" syntax to specify constraints.

If there are multiple constraints, we specify them one after another as shown below
```
func :: forall a b c. SomeTClass a => OtherTClass b => a -> b -> c -> c
```
In the above example, we have two type class constraints, "a" has to have an instance of "SomeTClass" type class. "b" has to have an instance of "OtherTClass" type class.

### Defining instances of type classes

Defining an instance of "DoingCalc" for our Shape ADT.

```
instance shapeCalc :: DoingCalc Shape where
  doCalc :: Shape -> Int
  doCalc (Circle p radius) = 1
  doCalc (Rectangle p w h) = 2
  doCalc (Line p0 p1) = 3
  doCalc (Text p text) = 4
```

In general, syntax is
```
instance instanceName :: TypeClassName [one or more type for matching the quantified types] where
  -- implementation of the list of functions specified in the type class definition
```
