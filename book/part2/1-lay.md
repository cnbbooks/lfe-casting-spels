## World Objects

Our game is going to have some objects in it that the player can pick up and use -- let's define those objects:

```lisp
> (set *objects* '(whiskey-bottle bucket frog chain))
```
```lisp
(whiskey-bottle bucket frog chain)
```

Ok, now let's dissect this line an see what it means: Since a Lisp compiler always starts reading things in *Code Mode* and expects a form, the first symbol, ``set``, must be a command. In this case, the command sets a variable to a value: The variable is ``*objects*`` (Lispers like to put stars around the names for global variables as a convention; these are sometimes referred to as "ear muffs"). The value we are setting it to is a list of the four objects in our game. Now, since the list is data (i.e. we don't want the compiler to try and call a function called ``whiskey-bottle``) we need to "flip" the compiler into ``Data Mode`` when reading the list. The single quote in front of the list is the command that tells the compiler to flip:

![](../images/objects.jpg)

Don't let these concepts go fuzzy in your brain! You're going to see them again soon ...
