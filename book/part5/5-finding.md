## Finding Things

We still have one thing we need to describe: If there are any objects on the floor at the location we are standing in, we'll want to describe them as well. Let's first write a helper function that tells us wether an item is in a given place:

```lisp
(defun there?
  ((loc (match-object location obj-loc)) (when (== loc obj-loc))
      'true)
  ((_ _)
      'false))
```

Here we've got some more pattern-matching arguments. Out function above is *2-arity* (meaning it takes two arguments). The first argument is the location, and the second argument is an expression for matching a record -- in this case, an ``object`` record. But we've added something new: the ``when`` form. When you see a ``(when ...)`` after a pattern in LFE, it's called a *guard*. This guard is standing watch over the pattern, and will only let the pattern match if the location that was passed as a regular function argument is the same as the object record's location.

That's the first fucntion head pattern that ``there?`` has. The second function head pattern has two arguments, just like the first one, but in this case they are both the "don't care" variable, the underscore. This part of the function is saying, "If you've made it past the first pattern without matching, I don't care what your location is or what your record is: I'm going to return ``false``.

Let's try out that function in the REPL. This will tell us if the first object
in the list of game objects is in the living room:

```lisp
> (there? 'living-room (car (state-objects state)))
true
> (there? 'attic (car (state-objects state)))
false
```

Remember that ``(state-objects state)`` returns all game objects.

We can put this to use listing all the objects in a given location by using
it with the ``lists:filter`` function. ``lists:filter`` takes two arguments:

1. A *predicate* function (a function that returns ``true`` or ``false``), given some input, and
1. A list of inputs to give the *predicate* function.

Here it is:

```lisp
(defun whats-here?
  (((match-state player player-loc objects objs))
    (lists:filter
      (lambda (obj)
        (there? player-loc obj))
      objs)))
```

Now let's try it out:



![](images/slob.jpg)

Let's try this out:

```lisp
> (whats-here? state)
```
```lisp
(#(object whiskey-bottle living-room) #(object bucket living-room))
```

Now let's use this function to describe the floor:

```lisp
(defun floor-item
  (((match-object name obj-name))
    (++ "You see a " (atom_to_list obj-name) " on the floor.")))

(defun describe-floor (game-state)
  (string:join
    (lists:map
      #'floor-item/1
      (whats-here? game-state))
    " "))
```

This function has a couple of new things: First of all, it has an *anonymous function* (``lambda`` is just a fancy word for this). The ``lambda`` form is just the same as defining a helper function ``(defun blabla (x) ...)`` and then sending ``#'blabla/1`` to the ``lists:filter/2`` function. This saves defining something that would only be called once. The ``filter/2`` function only keeps items in the list that are in the current location. Let's try this new function:

```lisp
(describe-floor state)
```
```lisp
"You see a whiskey-bottle on the floor. You see a bucket on the floor."
```

That was the last piece of the puzzle. Next we'll see how they fit together ...
