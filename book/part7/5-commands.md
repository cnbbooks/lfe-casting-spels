## Supporting Commands

[add opening notes about this section]

We're going to want to put a separator between each command:

```lisp
(defspel sent-prompt ()
  '(list_to_atom (string:copies "-" 78)))
```

Not only does that help us keep the command history clearly delineated, it takes care of that pesky problem of seeing the return value from calling the ``(! ...)`` function.

Speaking of which: since we're going to been to make so many calls to ``(! ...)`` (one for each command), how about we create a SPEL for that -- it will make things much cleaner:

```lisp
(defspel send (args)
  `(progn
    (! (whereis 'game-server) ,args)
    ',(sent-prompt)))
```

Now let's create the commands that we will type: the SPELs that will send messages to our little game "server":

```lisp
(defspel go (direction)
  `(send #(go ,direction)))

(defspel look ()
  `(send #(look)))

(defspel exits ()
  `(send #(exits)))

(defspel inv ()
  `(send #(inv)))

(defspel take (item)
  `(send #(take ,item)))

(defspel weld (subj obj)
  `(send #(weld ,subj ,obj)))

(defspel dunk (subj obj)
  `(send #(dunk ,subj ,obj)))

(defspel splash (subj obj)
  `(send #(splash ,subj ,obj)))
```

Now that we've got some new SPELs, let's try them out:

```lisp
> (look)
------------------------------------------------------------------------------
>
You are in the living-room of a wizard's house. There is a wizard snoring loudly on the couch.
You see a whiskey-bottle on the ground. You see a bucket on the ground.
There is a door going west from here. There is a stairway going upstairs from here.

(go west)
------------------------------------------------------------------------------
>
You are in a beautiful garden. There is a well in front of you.
You see a frog on the ground. You see a chain on the ground.
There is a door going east from here.
```

Look at that! No more state -- we're not passing it and we're not seeing it returned! The closures are taking care of that for us. We haven't abandoned the *functional programming way* -- our game code is still not mutating any data. We've just "hidden" the plumbing, as it were, with the raised floor of closures :-)

Well, it looks like we're finally ready to play our game!
