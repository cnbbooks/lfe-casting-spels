## Complex Interactions

We've just implemented some simple interactions like picking up objects or checking our player's inventory. What about interacting with the world on a conditional basis? We need add these sorts of actions to the game so that the player can meed the conditions to *win* in the game.

Now we're to the bit about goals. Let's write some functions that will help us get info about goals and set the status of goals.

```lisp
(defun goal-matches?
  ((goal-name (= (match-goal name name) goal)) (when (== goal-name name))
    `#(true ,goal))
  ((_ _)
    'false))

(defun filter-goals (goal-name game-state)
  (lists:filtermap
    (lambda (x) (goal-matches? goal-name x))
    (state-goals state)))

(defun extract-goal
  (('())
    'undefined)
  ((`(,goal))
    goal))

(defun get-goal (goal-name game-state)
  (extract-goal (filter-goals goal-name game-state)))

(defun goal-met? (goal-name game-state)
  (let ((goal (get-goal goal-name game-state)))
    (if (== goal 'undefined)
        goal
        (goal-achieved? goal))))
```

There are a couple of things in this code you haven't yet seen:

* the odd ``(= ...)`` form, and
* ``lists:filtermap``

The ``(= ...)`` form is not an equality test! In LFE, you can test if two things are equal with ``(== ...)`` or ``(=:= ...)``. So what is ``(= ...)``, then? If you look at it, you see that it's wrapping a record matching in the function arguments. In our match, we only care about one field from the goal record: ``name``. And we only care if it matches the passed argument ``goal-name``. Let's say our match succeeds, that the chain is already welded ... now what? We don't have any variables defined! Our function needs to return the game state, so how do we get it?

In LFE record-matching, you have the ability to not only match individual fields from a record, but to wrap the whole matching up and assign the passed record to a variable. You do that with the ``(= ...)`` form!

The function ``lists:filtermap`` does what you might guess: it performs a ``map`` and a ``filter`` simultaneously. In order to use this, the function passed to ``lists:filtermap`` needs to return ``false`` for a bad match and a tuple of ``#(true ,value)`` for a good match. In our case, the value is the matching goal.

Also, don't let the ``(goal-acheived? ...)`` call confuse you -- that's the magically created function for the ``goal`` record's ``achieved?`` field!

So we've managed to get goal information -- what about updating goals? We can do the same thing that we did for updating objects:

```lisp
(defun good-goal (item-name)
  (io:format "~nYou have achieved the '~s' goal!~n"
             (list (atom_to_list item-name))))

(defun check-goal
  ((goal-name (= (match-goal name g-name) goal)) (when (== goal-name g-name))
    (good-goal goal-name)
    (set-goal-achieved? goal 'true))
  ((_ goal) goal))

(defun update-goals (goal-name game-state)
  (set-state-goals
    game-state
    (lists:map
      (lambda (goal) (check-goal goal-name goal))
      (state-goals game-state))))
```

The first of the goals we'll write code for is the welding of the chain to the bucket in the attic:

```lisp
(defun weld-ready? (game-state)
  (andalso (inv? 'bucket game-state)
           (inv? 'chain game-state)
           (== (state-player game-state) 'attic)))
```

As you can see, that function checks to make sure that all the necessary conditions are present for a successful welding.

We're going to need some functions that print messages to the player; let's create those now:

```lisp
(defun weld-not-ready ()
  (io:format "~nYou seem to be missing a key condition for welding ...~n"))

(defun cant-weld ()
  (io:format "~nYou can't weld like that ...~n"))

(defun good-weld (game-state)
  (io:format "~nThe chain is now securely welded to the bucket.~n")
  game-state)

(defun already-welded ()
  (io:format "~nYou have already welded the bucket and chain!~n"))
```

Notice that our ``good-weld`` function takes the game state as a parameter, unlike the other functions. This is us planning for the future :-) We may want to do something with the game state *after* we check for a good weld ...

And now for the welding!

```lisp
(defun weld-them
  (('chain 'bucket game-state)
    (let ((ready? (weld-ready? game-state)))
      (cond ((goal-met? 'weld-chain game-state)
              (already-welded)
              game-state)
            ((not ready?)
              (weld-not-ready)
              game-state)
            (ready?
              (good-weld
                (update-goals 'weld-chain game-state))))))
  ((_ _ game-state)
    (cant-weld)
    game-state))
```

All of the code above should be familiar to you now, and with that, we've pieced together all our various functions to give our game a new action.

![](../images/weld.jpg)

Let's try our new command:


```lisp
> (weld-them 'chain 'bucket state)
```
```lisp
You seem to be missing a key condition for welding ...
```

Oops... we're don't have a bucket or chain, do we? ...and there's no welding machine around... oh well...

Now let's create a command for dunking the chain and bucket in the well. We'll need similar functions for this action:

```lisp
(defun dunk-ready? (game-state)
  (andalso (inv? 'bucket game-state)
           (goal-met? 'weld-chain game-state)
           (== (state-player game-state) 'garden)))

(defun dunk-not-ready ()
  (io:format "~nYou seem to be missing a key condition for dunking ...~n"))

(defun cant-dunk ()
  (io:format "~nYou can't dunk like that ...~n"))

(defun good-dunk (game-state)
  (io:format "~nThe bucket is now full of water.~n")
  game-state)

(defun already-dunked ()
  (io:format "~nYou filled the bucket. Again.~n"))

(defun dunk-it
  (('bucket 'well game-state)
    (let ((ready? (dunk-ready? game-state)))
      (cond ((goal-met? 'dunk-bucket game-state)
              (already-dunked)
              game-state)
            ((not ready?)
              (dunk-not-ready)
              game-state)
            (ready?
              (good-dunk
                (update-goals 'dunk-bucket game-state))))))
  ((_ _ game-state)
    (cant-dunk)
    game-state))
```

Hrm ... what can we do about that repititive code?

