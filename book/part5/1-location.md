## Location, Location, Location

The first command we'd want to have is a command that tells us about the location we're standing in. So what would a function need to describe a location in a world? Well, it would need to know the location we want to describe and would need to be able to look at a map and find that location on the map.

We can get there in stages by plying with our new game state and record fucntions. Getting the player location is super-easy:

```lisp
> (state-player state)
living-room
```

What about a place's description? Well, that burried a few more levels deep in our game state. Let's take a look. Let's refresh our memories about the fields defined in the records we will be accessing:

```lisp
> (fields-state)
(objects places player)
> (fields-map)
(living-room garden attic)
> (fields-place)
(description exits)
```

Let's imagine our location is in ``living-room`` (which, indeed, it is...).

![](images/living_room.jpg)

To get the ``description`` field, we'll need a ``place`` record; to get the place, we'll need a specific field from the ``map`` record (in this case, ``living-room``), and to get the ``map`` record, we'll need the ``places`` field of the ``state`` record. Let's do it:

```lisp
> (place-description
    (map-living-room
      (state-places state)))
"You are in the living-room of a wizard's house. There is a wizard snoring loudly on the couch."
>
```

Hey, that wasn't so bad! But how do we turn this into a function? Well, that's a bit trickier, since depending upon the location, a different ``(map-<location> ...)`` function will need to be called. We'll need to get the location, check it's value, and then call the appropriate ``(map-<location> ...)`` function.

Here's one way you could create this function in LFE:

```lisp
(defun describe-location
  (((match-state player player-loc places map-data))
    (case player-loc
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

(Shortly, we will be learning some Lispy magic that will make this implementation much, much shorter!)

We've seen ``defun`` before, but not ``let``. The ``let`` form is one of the ways in which you can define a local variable in LFE. We are interested in two varibales, here: the player location and the map data, or the ``places`` field in the game state. Then, depending upon the location, we need to execute a different record function: the living room, garden, and attic each have their own map data. As such, we need to check the location. In Lisp dialects like Common Lisp, this would be done with the ``cond`` form. We could use that as well, but LFE also provides other possibilities: ``cond``, *pattern matching* in function arguments, and the ``case`` form. We chose the ``case`` form above. The ``case`` for takes an expression and then a list of patterns to match the expression against. In this case, the variable ``player-location`` is matched against one of ``'living-room``, ``'garden``, or ``'attic``. Whichever one matches executes the expression after its pattern.

Note that functions in Lisp are often more like functions in math than in other programming languages: Just like in math, this function doesn't print stuff for the user to read or pop up a message box: All it does is return a value as a result of the function that contains the description.

Now let's use our new function:

```lisp
> (describe-location state)
```
```lisp
"You are in the living-room of a wizard's house. There is a wizard snoring loudly on the couch."
```

Perfect! Just what we wanted.
