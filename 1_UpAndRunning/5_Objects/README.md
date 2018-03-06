## Objects / Records / KeyValue pairs
Records are equivalent to JavaScript Objects(dictionary in python, map in java and c++). A record is a collection of Key Value pairs.

### Creating a Record
```
lang = {type : "Functional", name : "PureScript", id :1}
-- {key1 : value1, key2: value2, key3: value3} and so on
```

### Accessing elements from the Record
```
lang = {type : "Functional", name : "PureScript"}

main = log lang.type -- logs "Functional" on the console
-- basically, we use the "." (dot) notation to access elements from a record by specifying the key
```

### Changing the values inside a record (well, sort of)
```
langPS = {type : "Functional", name : "PureScript"}

langHK = langPS {name = "Haskell"} -- changes only name, returns a new Record

-- langHK.name is Haskell
-- langHK.type is Functional
```


### Remember, Records are IMMUTABLE
