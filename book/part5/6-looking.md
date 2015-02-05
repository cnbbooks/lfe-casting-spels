## Putting It All Together

Now we can tie all these descriptor functions into a single, easy command called ``look/0`` that uses the global variables (therefore this function is not in the *Functional Style*) to feed all the descriptor functions and describes **everything**:

```lisp
(defun look (game-state)
  (io:format
    "~s~n~s~n~s~n"
    (list (describe-location game-state)
          (describe-exits game-state)
          (describe-items game-state))))
```

![](images/functional.jpg)

Let's try it:

```lisp
> (look)
```
```lisp
You are in the living-room of a wizard's house. There is a wizard snoring loudly on the couch.
There is a door going west from here. There is a stairway going upstairs from here.
You see a whiskey-bottle on the floor. You see a bucket on the floor.
ok
```

Pretty cool!
