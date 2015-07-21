## The Winning Move

We're still missing one last special action: the one that will let us win the game! Just like with the last two, we're going to create some helper functions:

```lisp
(defun splash-ready? (game-state)
  (andalso (inv? 'bucket game-state)
           (goal-met? 'dunk-bucket game-state)
           (== (state-player game-state) 'living-room)))

(defun splash-not-ready ()
  (io:format "~nYou seem to be missing a key condition for splashing ...~n"))

(defun cant-splash ()
  (io:format "~nYou can't splash like that ...~n"))

(defun won-msg ()
  (io:format (++ "~nThe wizard awakens from his slumber, greets you "
                 "warmly, and thanks you for~npulling him out of a rather "
                 "nasty dream.~nYour reward, it seems, is a magical "
                 "low-carb donut which he hands you ...~nright before "
                 "drifting off to sleep again.~n~nYou won!!~n")))

(defun lost-msg ()
  (io:format (++ "~nThe wizard awakens to see that you are in possession "
                 "of his most precious --~nand dangerous! -- frog.~nHe "
                 "completely looses it.~nAs he waves his wand at you, "
                 "everything disappears ...~n")))

(defun good-splash (game-state)
  (case (inv? 'frog game-state)
    ('false
      (won-msg)
      game-state)
    ('true
      (lost-msg)
      (set-state-player game-state 'netherworld))))

(defun already-splashed ()
  (io:format (++ "~nYou've already woken the wizard once. With a bucket full "
                 "of well water.~n"
                 "Best not push your luck.~n")))
```

![](../images/splash.jpg)

And now we can generate the code for splashing water on the wizard:

```lisp
> (game-action splash wizard bucket splash-wizard)
```
```lisp
do-splash
```
```lisp
(defspel splash-wizard (game-state)
  `(splash 'wizard 'bucket ,game-state))
```
```lisp
()
```

![](../images/donut.jpg)

There remains that rather unpleasant user experience, though ... seeing the game state for many of the commands we execute. Ah, but there's a clever solution to that!
