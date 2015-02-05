## Interacting

Now we'll create a command to pickup objects in our world. We'll need some helper functions for this:

1. Check to see if the item we seek is present
1. Check the object location to ``player`` for the object we seek
1. Update the list of objects
1. Update the game state


```lisp
(defun good-pick (item-name)
  (io:format "~nYou are now carrying the ~s.~n~n"
             (list (atom_to_list item-name))))
```

```lisp
(defun check-item
  ((item-name (= (match-object name obj-name) obj)) (when (== item-name obj-name))
    (good-pick item-name)
    (set-object-location obj 'player))
  ((_ obj) obj))
```

```lisp
(defun update-items (item-name game-state)
  (lists:map
    (lambda (obj) (check-item item-name obj))
    (state-objects game-state)))
```

```lisp
(defun get-item-names (game-state)
  (lists:map
    (lambda (x) (object-name x))
    (whats-here? game-state)))
```

```lisp
(defun bad-pick ()
  (io:format "~nThat item is not here.~n~n"))
```


```lisp
(defun pickup-item
  ((item-name (= (match-state player player-loc objects objs) game-state))
    (case (lists:member item-name (get-item-names game-state))
          ('true
            (set-state-objects state (update-items item-name game-state)))
          ('false
            (bad-pick)
            game-state)))
  ((_ game-state) game-state))
```

[add description]

Now let's cast another SPEL to make the command easier to use:

```lisp
(defspel pickup (item-name game-state)
  `(pickup-item ',item-name ,game-state))
```

Now let's try our new SPEL:

```lisp
> (pickup whiskey-bottle state)
```
```lisp

You are now carrying the whiskey-bottle.

```

```lisp
>  (pickup frog state)
```
```lisp

That item is not here.

```

Now let's add a couple more useful commands: first, a command that lets us see our current inventory of items we're carrying:

```lisp
(defun inv-obj
  (((match-state objects objs))
    (lists:filter
      (match-lambda
        (((match-object location 'player)) 'true)
        ((_) 'false))
      objs)))
```

```lisp
(defun inv-name (game-state)
  (lists:map
    (lambda (x) (object-name x))
    (inv-obj game-state)))
```

```lisp
(defun inv (game-state)
  (io:format "~nYou are carrying:~n")
  (lists:foreach
    (lambda (x) (io:format " - ~s~n" (list x)))
    (inv-name game-state))
  (io:format "~n"))
```


Now a function that tells us if he have a certain object on us:

```lisp
(defun inv? (item-name game-state)
  (lists:member item-name (inv-name game-state)))
```
