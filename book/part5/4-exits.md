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

That's pretty straight forward, but there's another way we could write this function, too -- a way that would take advantage of extracting record data *in the function arguments*:

```lisp
(defun describe-exit
  (((match-exit object obj direction dir))
    (++ "There is a " obj " going " dir " from here.")))
```

LFE supports something called *pattern matching* thanks to its heritage from Erlang, and before that, Prolog. Many of the Lisp forms in LFE support *pattern matching*, and one of those is a function definition: you can put patterns in the arguments. However, when you do this, you need to make some changes, as you saw above: an extra parentheses is needed. Functions without pattern matching in their
arguments look like this, as we saw in the last chapter:

```lisp
(defun <name> (<arg> ...)
  <body>)
```

Whereas functions *with* pattern matching in their arguments look like this:

```lisp
(defun <name>
  ((<pattern>)
    body)
  ((<pattern>)
    body)
  ...)
```

You can have as many different patterns and associated function bodies as you want -- as long as they all have the same arity. Our pattern was a call to one of the magical functions created by our ``exit`` record, ``match-exit``. So what got filled in the ``<pattern>`` slot was a ``(match-exit ...)`` call, and that explains why you saw three opening parentheses in a row.

Let's try it out first and then figure out how it does what it does later. We're going to need some testing data, though:

```lisp

> (set test-exit (car
                   (place-exits
                     (map-living-room *map*))))
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

Now we can describe an exit, but see what we had to do to get our exit data? ``(place-exits ...)`` returns a *list* (and we called ``car`` to get the first element of that list). All of the place records have a list of exits (even if there's only one of them). As such, we need a function what will describe one or many exits. Things will be easier to read if we do this the
Lisper way, and create a helper function that "wraps" our magically-created
record ``place-exits`` function. This function needs the same logic as the function from last chapter that got location descriptions. Now we're getting a different field from the same record.

However, we've just learned about pattern matching, so let's put that knowledge to use:[^1]

```lisp
(defun get-exits
  (('living-room map-data)
    (place-exits
      (map-living-room map-data)))
  (('garden map-data)
    (place-exits
      (map-garden map-data)))
  (('attic map-data)
    (place-exits
      (map-attic map-data))))
```

That's our helper-function. Now for the one that does the heavy-lifting:

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


----

[^1]: As with the function from last chapter, we'll soon see a version of this function that is much shorter and eliminates the repetition.
