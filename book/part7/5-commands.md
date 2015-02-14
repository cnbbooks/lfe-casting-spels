## Supporting Commands

[add opening notes about this section]

We're going to want to put a separator between each command:

```lisp
(defspel sent-prompt ()
  '(list_to_atom (string:copies "-" 78)))
```

Not only does that help us keep the command history clearly delineated, it takes care of that pesky problem of seeing the return value from calling the ``(! ...)`` function.

Speaking of which: since we're going to been to make so many calls to ``(! ...)`` (one for each command), how about we create a SPEL for that -- it will make things much cleaner:

```lisp
(defspel send (args)
  `(progn
    (! (whereis 'game-server) ,args)
    ',(sent-prompt)))
```

Now let's create the commands that we will type: the SPELs that will send messages to our little game "server":

```lisp
(defspel go (direction)
  `(send #(go ,direction)))

(defspel look ()
  `(send #(look)))

(defspel exits ()
  `(send #(exits)))

(defspel inv ()
  `(send #(inv)))

(defspel take (item)
  `(send #(take ,item)))

(defspel weld (subj obj)
  `(send #(weld ,subj ,obj)))

(defspel dunk (subj obj)
  `(send #(dunk ,subj ,obj)))

(defspel splash (subj obj)
  `(send #(splash ,subj ,obj)))
```

Now that we've got some new SPELs, let's try them out:

```lisp
> (look)
------------------------------------------------------------------------------
>
You are in the living-room of a wizard's house. There is a wizard snoring loudly on the couch.
You see a whiskey-bottle on the ground. You see a bucket on the ground.
There is a door going west from here. There is a stairway going upstairs from here.
```

Look at that! No more state -- we're not passing it and we're not seeing it returned! The closures are taking care of that for us. We haven't abandoned the *functional programming way* -- our game code is still not mutating any data. We've just "hidden" the plumbing, as it were, with the raised floor of closures :-)

But ... the lines are a bit long. Let's make some changes to fix that. Here's
some code for wrapping long lines:

```lisp
(defun make-regex-str (max-len)
  (++ "(.{1," (integer_to_list max-len) "}|\\S{"
      (integer_to_list (+ max-len 1)) ",})(?:\\s[^\\S\\r\\n]*|\\Z)"))

(defun wrap-text (text max-len)
  (let ((find-patt (make-regex-str max-len))
        (replace-patt "\\1\\\n"))
    (re:replace text find-patt replace-patt
                '(global #(return list)))))

(defun wrap-text (text)
  (wrap-text text 78))
```

And we can use that to update our ``display-scene/1`` and ``display-exits/1`` functions:

```lisp
(defun display-scene (game-state)
  (io:format
    "~n~s~s~s"
    (lists:map
      #'wrap-text/1
      `(,(describe-location game-state)
        ,(describe-items game-state)
        ,(describe-exits game-state)))))

(defun display-exits (game-state)
  (io:format
    "~n~s"
    (list (wrap-text (describe-exits game-state)))))
```

Let's try again, with our display functions updated to wrap long text:

```
> (stop)
#(status game-over)
> (start)
#(status started)
> (look)
------------------------------------------------------------------------------
>
You are in the living-room of a wizard's house. There is a wizard snoring
loudly on the couch.
You see a whiskey-bottle on the ground. You see a bucket on the ground.
There is a door going west from here. There is a stairway going upstairs from
here.
```

Ah, much better :-)

Well, it looks like we're finally ready to play our game!
