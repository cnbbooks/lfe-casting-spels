## Making a Game Server

Assuming that you've already defined the variables in this function, you can
create a game-state initializer like so:

```lisp
(defun init-state ()
  (make-state
    objects objects
    places (list living-room garden attic netherworld)
    player 'living-room
    bucket-filled? 'false
    chain-welded? 'false
    won? 'false)))
```

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
```

```lisp
(defun start ()
  (let ((server-pid (spawn (lambda () (loop-server (init-state))))))
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

Try some of the other commands:

```lisp
> (stop)
#(status game-over)
> (stop)
#(status already-stopped)
> (start)
#(status started)
```
