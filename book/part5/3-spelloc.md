## Location, Part Deux

Now that we've got SPELs enabled, let's cast our first one: ``get-data``:

```lisp
> (defspel get-data (loc map-data)
    (let* ((loc-str (atom_to_list (eval loc)))
           (func-str (++ "map-" loc-str))
           (func-name (list_to_atom func-str)))
    `(,func-name ,map-data)))
()
```

We've just cast a SPEL that let's use dynamically generate the functions to get location data from our game map. The ``let*`` form is almost the same as the ``let`` form: you use ``let*`` when you need to refer to variables you just defined. For example, when we defined ``func-str``, we refered to the ``loc-str`` variable we just defined. The variables in that SPEL aren't necessary, though -- we did that for the sake of clarity. We could just as easily have defined ``get-data`` like this:

```lisp
> (defspel get-data (loc map-data)
    (let* ((loc-str (atom_to_list loc))
           (func-str (++ "map-" loc-str))
           (func-name (list_to_atom func-str)))
    `(,func-name ,map-data)))
```
```lisp
()
```

```lisp
(defspel get-data (loc map-data)
    `(,(list_to_atom (++ "map-" (atom_to_list loc))) ,map-data))
```

Let's use our new SPEL:

```lisp
> (get-data living-room (state-places state))
```
```lisp
#(place
  "You are in the living-room of a wizard's house. There is a wizard snoring loudly on the couch."
  (#(exit "west" "door" garden) #(exit "upstairs" "stairway" attic)))
```

Fantastic! Now let's put it to use in rewriteing our ``describe-location`` function:


```lisp
> (defun describe-location (game-state)
    (place-description
       (get-data (state-player game-state)
                 (state-places game-state))))
```


Compare this to our original ``describe-location`` function:

```lisp
(defun describe-location (game-state)
  (let ((player-location (state-player game-state))
        (map-data (state-places game-state)))
    (case player-location
          ('living-room
            (place-description
              (map-living-room map-data)))
          ('garden
            (place-description
              (map-garden map-data)))
          ('attic
            (place-description
              (map-attic map-data))))))
```
