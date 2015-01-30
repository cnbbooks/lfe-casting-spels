## Location, Location, Location

The first command we'd want to have is a command that tells us about the location we're standing in. So what would a function need to describe a location in a world? Well, it would need to know the location we want to describe and would need to be able to look at a map and find that location on the map. Here's our function, and it does exactly that:

```lisp
(defun describe-location (location map)
  (place-description
    (proplists:get_value 'living-room *map*)))
```

The word ``defun`` means, as you'd expect, that we're defining a function. The name of the function is ``describe-location`` and it takes two parameters: a ``location`` and a ``map``. Since these variables do not have stars around them, it means they are local and hence unrelated to the global ``*location*`` and ``*map*`` variables. Note that functions in Lisp are often more like functions in math than in other programming languages: Just like in math, this function doesn't print stuff for the user to read or pop up a message box: All it does is return a value as a result of the function that contains the description.

Remember how we said we were creating *property lists*? Well, Erlang provides
us with functions work working with these, and in our ``describe-location``
function, we've used the ``proplists`` module's ``get_value`` function.

Once we have the data for our location -- which, if you remember, is a *record* --
we can get the bit that we need right now. When we created our ``location``
record, a bunch of functions were created for us at the same time (it's magical!).
This include the ``place-descroption`` function we've used above.

Let's imagine our location is in ``living-room`` (which, indeed, it is...).


![](images/living_room.jpg)

To find the description for this, it first needs to look up the spot in the map that points to the living-room. The assoc command does this and then returns the data describing the living-room. Then the command second trims out the second item in that list, which is the description of the living-room (If you look at the ``*map*`` variable we had created, the snippet of text describing the living-room was the second item in the list that contained all the data about the living room...)

Now let's use our new function:

```lisp
> (describe-location 'living-room *map*)
```
```lisp
"You are in the living-room of a wizard's house. There is a wizard snoring loudly on the couch."
```

Perfect! Just what we wanted... Notice how we put a quote in front of the symbol ``living-room``, since this symbol is just a piece of data naming the location (i.e. we want it read in *Data Mode*) , but how we didn't put a quote in front of the symbol ``*map*``, since in this case we want the list compiler to hunt down the data stored in the ``*map*`` variable (i.e. we want the compiler to be in *Code Mode* and not just look at the word ``*map*`` as a chunk of raw data)
