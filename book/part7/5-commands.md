## Supporting Commands

```lisp
(defun sent-prompt () ''<-)

(defspel go (direction)
  `(progn
    (! ,(whereis 'game-server) (tuple 'go ',direction))
    ,(sent-prompt)))

(defspel view ()
  `(progn
    (! ,(whereis 'game-server) (tuple 'view))
    ,(sent-prompt)))

(defspel i ()
  `(progn
    (! ,(whereis 'game-server) (tuple 'inv))
    ,(sent-prompt)))

(defspel take (item)
  `(progn
    (! ,(whereis 'game-server) (tuple 'take ',item))
    ,(sent-prompt)))
```

We've got some new SPELs -- let's try them out:

```lisp
(view)
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
