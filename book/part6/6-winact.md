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

(defun dunk-it
  ((_ _ (= (match-state bucket-filled? 'true) game-state))
    (already-dunked)
    game-state)
  (('bucket 'well game-state)
    (case (dunk-ready? game-state)
        ('true
          (good-dunk)
          (set-state-bucket-filled? game-state 'true))
        ('false
          (dunk-not-ready)
          game-state)))
  ((_ _ game-state)
    (cant-dunk)
    game-state))

(game-action splash bucket wizard living-room
             (cond ((not *bucket-filled*) '(the bucket has nothing in it.))
                   ((have 'frog) '(the wizard awakens and sees that you stole his frog.
                                   he is so upset he banishes you to the
                                   netherworlds- you lose! the end.))
                   (t '(the wizard awakens from his slumber and greets you warmly.
                        he hands you the magic low-carb donut- you win! the end.))))

And now the code for splashing water on the wizard:


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
> 
```

![](../images/donut.jpg)
