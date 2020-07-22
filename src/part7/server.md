# Making a Game Server

Given what we're learned so far, we're ready to make a small process "server" that will hold our game's state. We can then send messages to it that will execute the functions we've defined. Here's a list of the commands we need to support in order to play the game:

* look
* walk (we'll use "go" instead)
* pickup (we'll use "take" instead)
* inv
* weld
* dunk
* splash

Assuming that you've already defined the variables in this function, you can
create a game-state initializer like so:

```lisp
(defun init-state ()
  (make-state
    objects objects
    places (list living-room garden attic netherworld)
    player-location 'living-room
    goals goals))
```

There's one more thing we can do, though: take pity on the overly-curious and inclined-to-steal-frogs. Let's make sure that a player who takes too strong an interest in making new amphibian friends can amend their ways:

```lisp
(defun spell-of-mercy ()
  (timer:sleep 2000)
  (io:format (++ "~nFrom deep in the mists, you hear a familiar intonation ...~n"
                 "Great relief washes over you, as you recognize the "
                 "time-travel spell -- you're~nnot doomed!~n~n"))
  (timer:sleep 4000)
  (io:format (++ "Confident that you will never pick up the frog again, "
                 "things get a bit fuzzy.~nYou start to lose consciousness"
                 "as the wizard pulls you back in time. Your~nlast thought is "
                 "that you're probably not going to remember any of this "
                 "...~n~n"))
  (timer:sleep 4000)
  (let ((state (init-state)))
    (display-scene state)
    state))
```

Now we can create our state holder "server":

```lisp
(defun loop-server (state)
  (receive
    (`#(look)
      (display-scene state)
      (case (state-player-location state)
        ('netherworld (loop-server (hope-for-mercy state)))
        (_ (loop-server state))))
    (`#(exits)
      (display-exits state)
      (loop-server state))
    (`#(go ,direction)
      (loop-server (walk-direction direction state)))
    (`#(take ,item)
      (loop-server (pickup-item item state)))
    (`#(inv)
      (display-inv state)
      (loop-server state))
    (`#(weld ,subj ,obj)
      (loop-server (do-weld subj obj state)))
    (`#(dunk ,subj ,obj)
      (loop-server (do-dunk subj obj state)))
    (`#(splash ,subj ,obj)
      (loop-server (do-splash subj obj state)))))

(defun loop-server ()
  (loop-server (init-state)))
```

```lisp
(defun start ()
  (case (whereis 'game-server)
    ('undefined
      (let ((server-pid (spawn #'loop-server/0)))
        (register 'game-server server-pid)
        '#(status started)))
    (_ '#(status already-started))))

(defun stop
  (('undefined _)
    '#(status already-stopped))
  ((pid msg)
    (exit pid msg)
    `#(status ,msg)))

(defun stop ()
  (stop (whereis 'game-server) 'game-over))
```

Start up your new game server!

```lisp
lfe> (start)
#(status started)
```

Try starting (again), stopping and restarting:

```lisp
lfe> (start)
#(status already-started)
lfe> (stop)
#(status game-over)
lfe> (stop)
#(status already-stopped)
lfe> (start)
#(status started)
```

Next, we can cast some new SPELs for use with our server ...
