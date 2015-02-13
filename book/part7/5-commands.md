## Supporting Commands

[add notes about this section]

[add missing commands]

```lisp
(defspel sent-prompt ()
  '(list_to_atom (string:copies "-" 78)))

(defspel send (args)
  `(progn
    (! (whereis 'game-server) ,args)
    ',(sent-prompt)))

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

We've got some new SPELs -- let's try them out:

```lisp
(look)
<-
>
You are in the living-room of a wizard's house. There is a wizard snoring loudly on the couch.
You see a whiskey-bottle on the ground. You see a bucket on the ground.
There is a door going west from here. There is a stairway going upstairs from here.

(go west)
<-
>
You are in a beautiful garden. There is a well in front of you.
You see a frog on the ground. You see a chain on the ground.
There is a door going east from here.
```

Look at that! No more state -- we're not passing it and we're not seeing it returned! The closures are taking care of that for us. We haven't abandoned the *functional programming way* -- our game code is still not mutating any data. We've just "hidden" the plumbing, as it were, with the raised floor of closures :-)

Well, it looks like we're finally ready to play our game!
