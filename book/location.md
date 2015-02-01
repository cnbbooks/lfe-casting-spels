## Location, Location, Location

The first command we'd want to have is a command that tells us about the location we're standing in. So what would a function need to describe a location in a world? Well, it would need to know the location we want to describe and would need to be able to look at a map and find that location on the map. In Lisp,
a function like that would have this general form:

```lisp
(defun describe-location (location map-data)
  (case location
        ('living-room
          (place-description
            (map-living-room map-data)))
        ('garden
          (place-description
            (map-garden map-data)))
        ('attic
          (place-description
            (map-attic map-data)))))
```

The word ``defun`` means, as you'd expect, that we're defining a function. The name of the function is ``describe-location`` and it takes two arguments: a ``location`` and a ``map-data``. Depending upon the location, we need to execute a different function: the living room, garden, and attic each have their own map data. As such, we need to check the location. In Lisp dialects like Common Lisp, this would be done with the ``cond`` form. We have other choices available to us in LFE as well: *pattern matching* in function arguments and the ``case`` form. We chose the ``case`` form above.[^1]

Since these variables do not have stars around them, it means they are local and hence unrelated to the global ``*location*`` and ``*map*`` variables. Note that functions in Lisp are often more like functions in math than in other programming languages: Just like in math, this function doesn't print stuff for the user to read or pop up a message box: All it does is return a value as a result of the function that contains the description.

When we created our ``map`` record, we defined three fields: ``living-room``, ``garden``, and ``attic``. When a record is created, each field has two functions created for it (records are magical!): functions to get the field data and functions to set the field data. This is where the ``map-living-room``, ``map-garden``, and ``map-attic``functions came from.

The same is true for our ``place`` record: the ``place-description`` function was created to help us get the data stored in the ``description`` field out of the ``place``record.

Let's imagine our location is in ``living-room`` (which, indeed, it is...).


![](images/living_room.jpg)

To find the description for this, it first needs to look up the spot in the map that points to the living-room. The ``map-living-room`` function does this and then returns the data describing the living-room. Then the function ``place-description`` extracts the description of the living-room.

Now let's use our new function:

```lisp
> (describe-location 'living-room *map*)
```
```lisp
"You are in the living-room of a wizard's house. There is a wizard snoring loudly on the couch."
```

Perfect! Just what we wanted... Notice how we put a quote in front of the symbol ``living-room``, since this symbol is just a piece of data naming the location (i.e. we want it read in *Data Mode*) , but how we didn't put a quote in front of the symbol ``*map*``, since in this case we want the list compiler to hunt down the data stored in the ``*map*`` variable (i.e. we want the compiler to be in *Code Mode* and not just look at the word ``*map*`` as a chunk of raw data)

----

[^1]: We will cover *pattern matching* shortly. Here's what the function would have looked like with *pattern matching* in the function arguments:
  ```lisp
  (defun describe-location
    (('living-room map-data)
      (place-description
        (map-living-room map-data)))
    (('garden map-data)
      (place-description
        (map-garden map-data)))
    (('attic map-data)
      (place-description
        (map-attic map-data))))
  ```
