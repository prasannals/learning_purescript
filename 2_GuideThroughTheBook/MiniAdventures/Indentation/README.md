## Indentation

#### #whitespacesmatter
#### Indentation is meaningful in PureScript

Similar to languages like Python, indentation is used to group code blocks in PureScript.

* Code written in the same block will have the same indentation.
* Functions, where, do, of introduce a new block of code

![Imgur](https://i.imgur.com/PnaLakV.jpg)

If the indentation isn't proper, you will get a compilation error.

#### Side note - indentation in "if then else"

We can write "if then else" expressions in a single line. But if we're writing it in more than one line, we should indent the "then" and "else" part more than the "if" part. "then" and "else" have to be at the same level of indentation.

Example

```
func a b = if (a == 1)
             then if (b == 2)
                 then true
                 else false
             else false
```
