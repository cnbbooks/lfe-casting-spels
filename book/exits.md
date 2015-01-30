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

