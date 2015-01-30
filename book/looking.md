# Looking Around in Our Game World

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


## The Functional Programming Style

You may have noticed that our describe-location function seems pretty awkward in several different ways. First of all, why are we passing in the variables for location and map as parameters, instead of just reading our global variables directly? The reason is that Lispers often like to write code in the *Functional Programming Style* (To be clear, this is completely unrelated in any way to the concept called "procedural programming" or "structural programming" that you might have learned about in high school...). In this style, the goal is to write functions that always follow the following rules:


1. You only read variables that are passed into the function or are created by the function (So you don't read any global variables)
1. You never change the value of a variable that has already been set (So no incrementing variables or other such foolishness)
1. You never interact with the outside world, besides returning a result value. (So no writing to files, no writing messages for the user)

You may be wondering if you can actually write any code like this that actually does anything useful, given these brutal restrictions... the answer is yes, once you get used to the style... Why would anyone bother following these rules? One very important reason: Writing code in this style gives your program *referential transparency*: This means that a given piece of code, called with the same parameters, always positively returns the same result and does exactly the same thing no matter when you call it- This can reduce programming errors and is believed to improve programmer productivity in many cases.

Of course, you'll always have some functions that are not *functional* in style or you couldn't communicate with the user or other parts of the outside world. Most of the functions later in this tutorial do not follow these rules.

Another problem with our ``describe-location`` function is that it doesn't tells us about the exits in and out of the location to other locations. Let's write a function that describes these exits:

```lisp
(defun describe-exit (exit)
  `(There is a ,(second path) going ,(first path) from here.))
```
