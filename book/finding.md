## Finding Things

We still have one thing we need to describe: If there are any objects on the floor at the location we are standing in, we'll want to describe them as well. Let's first write a helper function that tells us wether an item is in a given place:

```lisp
(defun is-at (obj loc obj-locs)
  (if (== loc (proplists:get_value obj obj-locs))
      'true
      'false))
```

![](images/slob.jpg)

Let's try this out:

```lisp
> (is-at 'whiskey-bottle 'living-room *object-locations*)
```
```lisp
true
```

Getting the atom ``true`` as a result means that the whiskey-bottle is in living-room.

 Now let's use this function to describe the floor:

```lisp
(defun floor-item (x)
  (io_lib:format "You see a ~s on the floor." `(,(atom_to_list x))))

(defun describe-floor (loc objs obj-locs)
  (lists:flatten
    (string:join
      (lists:map
        #'floor-item/1
        (lists:filter (lambda (x) (is-at x loc obj-locs)) objs))
      " ")))
```

This function has a couple of new things: First of all, it has an *anonymous function* (``lambda`` is just a fancy word for this). The ``lambda`` form is just the same as defining a helper function ``(defun blabla (x) ...)`` and then sending ``#'blabla/1`` to the ``lists:filter/2`` function. The ``filter/2`` function only keeps items in the list that are in the current location. Let's try this new function:

```lisp
(describe-floor 'living-room *objects* *object-locations*)
```
```lisp
"You see a whiskey-bottle on the floor. You see a bucket on the floor."
```

That was the last piece of the puzzle. Next we'll see how they fit together ...
