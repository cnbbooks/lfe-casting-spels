## Making a Game Server

Given what we're learned so far, we're ready to make a small process "server" that will hold our game's state. We can then send messages to it that will execute the functions we've defined. Here's a list of the commands we need to support in order to play the game:

* look
* walk
* pickup
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
    player 'living-room
    goals goals))
```

[clean up loop-server code and add missing comands]

```lisp
(defun loop-server (state)
  (receive
    (`#(test)
      '#(ok test)
      (loop-server state))
    (`#(echo ,data)
      `#(ok ,data)
      (loop-server state))
    (`#(go ,direction)
      (loop-server (walk-direction direction state)))
    (`#(view)
      (look state)
      (loop-server state))
    (`#(inv)
      (inv state)
      (loop-server state))
    (`#(take ,item)
      (loop-server (pickup-item item state)))
    ))

(defun loop-server ()
  (loop-server (init-state)))
```

```lisp
(defun start ()
  (let ((server-pid (spawn #'loop-server/0)))
    (register 'game-server server-pid)
    '#(status started)))

(defun stop
  (('undefined _)
    '#(status already-stopped))
  ((pid msg)
    (exit pid msg)
    `#(status ,msg)))

(defun stop ()
  (stop (whereis 'game-server) 'game-over))
```

Start it up your new game server!

```lisp
> (start)
#(status started)
```

Try stopping and restarting:

```lisp
> (stop)
#(status game-over)
> (stop)
#(status already-stopped)
> (start)
#(status started)
```
