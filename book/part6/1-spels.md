## Introducing SPELs


### Too Much Repitition

You may have noticed that there is a lot of repition in our new function:

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

* We check the location.
* Then call ``map-<location name>``.
* Then call ``place-description``.
* And we do these each three times!

Often we writing functions it's pretty easy to *refactor* or get rid of the redunant bits by using new variables, creating more general functions, etc. But how can we do that here? It's the actual *function name* that would need to change!

May close attention, my friend, for you are about to embark on the journey of a Lisp magician: learning to cast SPELs.


### Semantic Program Enhancement Logic

SPEL is short for "Semantic Program Enhancement Logic" and lets us create new behavior inside the world of our computer code that changes the Lisp language at a fundamental level in order to customize its behavior for our needs- It's the part of Lisp that looks most like magic. To enable SPELs, we first need to activate SPELs inside our Lisp compiler (Don't worry about what this line does -- advanced Lispers should click [here](book/addendum/2-whyspels.md)):

```lisp
> (defmacro defspel body `(defmacro ,@body))
```
```
()
```

We can use SPELs to dynamically call functions, treating function names like variables. This is just what we need to make our ``describe-location`` function more concise: if we could just use the location variable in the function name for getting the map data, we could elliminate the need for the ``case`` form, cutting our code size by nearly $$\frac{2}{3}$$.
