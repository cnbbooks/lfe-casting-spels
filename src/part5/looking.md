## Putting These Pieces Together

Now we can tie all these descriptor functions into a single, easy command
called ``display-scene/1`` which calls all the descriptor functions and describes **everything**:

```lisp
(defun display-scene (game-state)
  (io:format
    "~n~s~s~s"
    (list (describe-location game-state)
          (describe-items game-state)
          (describe-exits game-state))))
```

Note that we're using an awkward name for now -- by the time we finish our game, we'll have created very easy game commands!

Let's try it:

```lisp
lfe> (display-scene state)
```
```lisp
You are in the living-room of a wizard's house. There is a wizard 
  snoring loudly on the couch.
You see a whiskey-bottle on the ground. You see a bucket on the ground.
There is a door going west from here. There is a stairway going upstairs from here.ok
```

Pretty cool!

Let's create another function for just displaying the exits, as that might come in handy during game-play:

```lisp
(defun display-exits (game-state)
  (io:format
    "~n~s"
    (list (describe-exits game-state))))
```
