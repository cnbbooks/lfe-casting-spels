## Walking Around In Our World

Ok, now that we can see our world, let's write some code that lets us walk around in it. Let's start with a helper function that lists the valid directions in which our player can move:

```lisp
(defun get-valid-moves (exits)
  (lists:map
    (lambda (x)
      (list_to_atom (exit-direction x)))
    exits))
```

Since we're in the living room right now, out two valid moves should be those that take us to the garden or to the attic:

```lisp
> (get-valid-moves (place-exits (get-here state)))
(west upstairs)
```

We used the same record function that we did in the "Exits" section: ``place-exits``, after getting the place record for our current location.

We've got our list of valid moves the player can make; what next? Well, once the player moves in a direction, we'll want to set that destination has the new location for the player. So, given a list of exits, we need to match the one that the player chose to use:

```lisp
(defun match-directions
  ((player-dir (match-exit direction dir))
    (if (== dir (atom_to_list player-dir))
        'true
        'false)))

(defun get-new-location (player-dir exits)
  (exit-destination
    (car
      (lists:filter
        (lambda (exit) (match-directions player-dir exit))
        exits))))
```

So, given a list of exits for the current location (``(place-exits (get-here state))``), what is the destination if the player choses to go ``west``?

```lisp
> (get-new-location 'west (place-exits (get-here state)))
```
```lisp
garden
```

Excellent!

Let's create some more helper functions: whever the player's move is good or bad, two things need to happen, and in this order:

1. A message needs to be displayed, and
1. The game state needs to be returned.

Let's make those functions now:

```lisp
(defun good-move (game-state)
  (display-scene game-state)
  game-state)

(defun bad-move (game-state)
  (io:format "~nYou can't go that way.~n")
  game-state)
```

With these in place, we're ready to create or first action:

```lisp
(defun walk-direction (direction game-state)
  (let ((exits (place-exits (get-here game-state))))
    (case (lists:member direction (get-valid-moves exits))
          ('true (good-move
                   (set-state-player
                     game-state
                     (get-new-location direction exits))))
          ('false (bad-move game-state)))))
```

What are you waiting for?! Let's try it!

```lisp
> (set state (walk-direction 'west state))
```
```lisp
You are in a beautiful garden. There is a well in front of you.
There is a door going east from here.
You see a frog on the floor. You see a chain on the floor.
```

You will also see the new state displayed in the REPL. We'll talk more about that later. (Don't worry, we're going to make it go away!)

It would be nice to adjust the ``walk-direction/2`` function so that it doesn't have an annoying quote mark in the command that the player has to type in. But, as we have learned, when the compiler reads a form in *Code Mode*, it will read all its parameters in *Code Mode*, unless a quote tells it not to.

Is there anything we can do to tell the compiler that west is just a piece of data without the quote?

Let's find out ...
