# Objects

For each object in the game, we need to know its name and location:

```lisp
(defrecord object
  name
  location)
```

Let's create some objects now, improving upon our initial "objects" exploration:

```lisp
lfe> (set objects
    (list (make-object name 'whiskey-bottle location 'living-room)
          (make-object name 'bucket location 'living-room)
          (make-object name 'frog location 'garden)
          (make-object name 'chain location 'garden)))
```

```lisp
(#(object whiskey-bottle living-room)
 #(object bucket living-room)
 #(object frog garden)
 #(object chain garden))
```

You are probably wondering where that mysterious `make-object` function came from. When you create a record in LFE, LFE creates several functions dynamically, just for use with your record: their names start with or have as part of their own names, the record name you used. For example, when you created the `state` and `object` records, LFE created the `make-state` and `make-object` functions (among several others -- more later).
