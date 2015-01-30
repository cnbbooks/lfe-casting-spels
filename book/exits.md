## Exits

Another problem with our ``describe-location`` function is that it doesn't tell us about the exits in and out of the location to other locations. Let's write a function that describes these exits:

```lisp
(defun describe-exit (exit-data)
  (++ "There is a "
      (exit-object exit-data)
      " going "
      (exit-direction exit-data)
      " from here."))
```

Ok, now this function looks pretty strange: It almost looks more like a piece of data than a function. Let's try it out first and figures out how it does what it does later. We're going to need some testing data, though:

```lisp

> (set exit (car
              (place-exits (proplists:get_value
                             'living-room
                             *map*))))
```

There: that gives us the first exit in the list of exits we got back from the
``place-exits`` call. Let's try these out:

```lisp
> (describe-exit exit)
```
```lisp
"There is a door going west from here."
```

Now we can describe a path, but see what we had to do to get our exit data? ``(place-exits ...)`` returns a *list* -- all of the place records have a list of exits (even if there's only one of them). As such, we need a function what will describe one or many exits. Things will be easier to read if we do this the
Lisper way, and create a helper function that "wraps" our magically-created
record ``place-exits`` function:

```lisp
(defun get-exits (location map)
  (place-exits
    (proplists:get_value location map)))
```

```lisp
(defun describe-exits (location map)
  (string:join
    (lists:map
      #'describe-exit/1
      (get-exits location map))
    " "))
```

This function uses another common *functional programming* technique: the use of *Higher Order Functions*. This means that the ``map`` function in the Erlang standard library's ``lists`` module is taking another function as a parameter so that they can call them themselves. To pass a function, you need to put ``#'`` in front of the function name and you much supply the *arity* or the number than indicates how many arguments the function takes. In Erlang and LFE functions are uniqely determined by a combination of the module in which they reside, the name of the function, and the *arity* of the function. This means that you could have many functions in one module that all share the same name, but take different numbers of arguments -- quite a nice feature, as you might imagine.

 What our function does is get a list of the exits records, passes each record to ``describe-exit/1``, and with the resulting list of exit descriptions, joins them together using a single space. Let's try this new function:

```lisp
> (describe-exits 'living-room *map*)
```
```lisp
"There is a door going west from here. There is a stairway going upstairs from here."
```

Beautiful!

Next, we'll want to find things ...
