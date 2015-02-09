## The Winning Move

We're still missing one last special action: the one that will let us win the game! Just like with the last two, we're going to create some helper functions:

```lisp
(defun splash-ready? (game-state)
  (andalso (not (inv? 'frog state))
           (state-bucket-filled? game-state)
           (== (state-player game-state) 'living-room)))

(defun splash-not-ready ()
  (io:format "~nYou seem to be missing a key condition for splashing ...~n~n"))

(defun cant-splash ()
  (io:format "~nYou can't splash like that ...~n~n"))

(defun good-splash (game-state)
  (case (inv? 'frog game-state)
    ('false
      (io:format (++ "~nThe wizard awakens from his slumber, greets you "
                     "warmly, and thanks you for pulling him out of a rather "
                     "nasty dream.~nYour reward, it seems, is a magical "
                     "low-card donut which hands you ... right before "
                     "drifting off to sleep again.~n~nYou won!~n~n"))
      game-state)
    ('true
      (io:format (++ "~nThe wizard awakens to see that you are in possession "
                     "of his most precious ... and dangerous ... frog.~nHe "
                     "completely looses it, then waves his wand at you.~n"
                     "Everything disappears ...~n~n"))
      (set-state-player game-state 'netherworld))))

(defun already-splashed ()
  (io:format (++ "~nYou've already woken the wizard once. With a bucket full "
                 "of well water.~n"
                 "Best not push your luck.~n~n")))
```

![](../images/splash.jpg)

And now we can generate the code for splashing water on the wizard:

```lisp
> (game-action splash wizard bucket won?)
```
```lisp
splash
```
```lisp
(defspel splash-wizard (game-state)
  `(splash 'wizard 'bucket ,game-state))
```
```lisp
()
```
```lisp
> (set state (splash-wizard state))
```

![](../images/donut.jpg)
