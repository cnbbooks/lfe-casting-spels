## Exits

One thing that our ``describe-location`` function doesn't do is tell us about the exits in and out of the current location to other locations. Let's write a function that describes these exits, starting with one exit:

```lisp
(defun describe-exit
  (((match-exit object obj direction dir))
    (++ "There is a " obj " going " dir " from here.")))
```

Let's try it out first and then figure out how to use it. To try it, we're going to need some testing data, though:

```lisp
> (set test-exit (car (place-exits
                        (car (state-places state)))))
```
```lisp
#(exit "west" "door" garden)
```

There: that gives us the first exit in the list of exits we got back from the
``place-exits`` call. Let's try these out:

```lisp
> (describe-exit test-exit)
```
```lisp
"There is a door going west from here."
```

Now we can describe an exit, but see what we had to do to get our exit data? ``(place-exits ...)`` returns a *list* (and we called ``car`` to get the first element of that list). All of the place records have a list of exits (even if there's only one of them). As such, we need a function what will describe one or many exits. Sounding familiar? Good! You're catching on!

In fact, it's so familiar, we can use the same ``get-here`` function that we used before!

```lisp
(defun describe-exits (game-state)
  (string:join
    (lists:map
      #'describe-exit/1
      (place-exits (get-here game-state)))
    " "))
```

What our ``describe-exits`` function does is build a list of strings and then joins them together with a space.

But we skipped over something. Remember how we used ``lists:map`` before? By passing it a ``lambda``? Well here, we're passing it a *named function*, not an *anonymous function*. To pass a function, you need to put ``#'`` in front of the function name, and then it's *arity* after the function name. So, we get a list of the exits records, pass each record to ``describe-exit/1``, and with the resulting list of exit descriptions, join them together using a single space.

Let's try this new function:

```lisp
> (describe-exits state)
```
```lisp
"There is a door going west from here. There is a stairway going upstairs from here."
```

Beautiful!

Next, we'll want to find things ...

