## Creating Special Actions

Before we tackle the issue of always setting the game ``state`` with every game command we type, we need to do one more thing: add some special actions to the game that the player has to do to win in the game. The first command will let the player weld the chain to the bucket in the attic:

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
  (io:format "~nYou seem to be missing a key condition for welding ...~n~n"))

(defun cant-weld ()
  (io:format "~nYou can't weld like that ...~n~n"))

(defun good-weld ()
  (io:format "~nThe chain is now securely welded to the bucket.~n~n"))

(defun already-welded ()
  (io:format "~nYou have already welded the bucket and chain!~n~n"))
```

And now for the welding!

```lisp
(defun weld-them
  ((_ _ (= (match-state chain-welded? 'true) game-state))
    (already-welded)
    game-state)
  (('chain 'bucket game-state)
    (case (weld-ready? game-state)
        ('true
          (good-weld)
          (set-state-chain-welded? game-state 'true))
        ('false
          (weld-not-ready)
          game-state)))
  ((_ _ game-state)
    (cant-weld)
    game-state))
```

We've pieced together all our function parts to give our game a new action. The one thing in this code you haven't yet seen is the odd ``(= ...)`` form -- that's not an equality test! In LFE, you can test if two things are equal with ``(== ...)`` or ``(=:= ...)``. So what is ``(= ...)``, then?

If you look at it, you see that it's wrapping a record matching in the function arguments. In our match, we only care about one field from the record: ``chain-welded?``. And we only care if it's ``true``. Let's say our match succeeds, that the chain is already welded ... now what? We don't have any variables defined! Our function needs to return the game state, so how do we get it?

In LFE record-matching, you have the ability to not only match individual fields from a record, but to wrap the whole matching up and assign the passed record to a variable. You do that with the ``(= ...)`` form!

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
           (== (state-chain-welded? game-state) 'true)
           (== (state-player game-state) 'garden)))

(defun dunk-not-ready ()
  (io:format "~nYou seem to be missing a key condition for dunking ...~n~n"))

(defun cant-dunk ()
  (io:format "~nYou can't dunk like that ...~n~n"))

(defun good-dunk ()
  (io:format "~nThe bucket is now full of water.~n~n"))

(defun already-dunked ()
  (io:format "~nWhy did you re-fill the bucket?~n~n"))

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
```

Now if you paid attention, you probably noticed that this command looks a lot like the weld command... Both commands need to check the location, subject, and object -- but there's enough making them different that we can't combine the similarities into a single function. Too bad...

...but since this is Lisp, we can do more than just write functions, we can cast SPELs! Let's create the following SPEL:

```lisp
(defspel game-action ...
  )
```

Notice how ridiculously complex this SPEL is- It has more weird quotes, backquotes, commas and other weird symbols than you can shake a list at. More than that it is a SPEL that actually cast ANOTHER SPEL! Even experienced Lisp programmers would have to put some thought into create a monstrosity like this (and in fact they would consider this SPEL to be inelegant and would go through some extra esoteric steps to make it better-behaved that we won't worry about here...)

![](../images/game_action.jpg)


The point of this SPEL is to show you just how sophisticated and clever you can get with these SPELs. Also, the ugliness doesn't really matter much if we only have to write it once and then can use it to make hundreds of commands for a bigger adventure game.

Let's use our new SPEL to replace our ugly ``weld-them`` command:

```lisp
(...)
```

Look at how much easier it is to understand this command- The game-action SPEL lets us write exactly what we want to say without a lot of fat- It's almost like we've created our own computer language just for creating game commands. Creating your own pseudo-language with SPELs is called Domain Specific Language Programming, a very powerful way to program very quickly and elegantly.

```lisp
> (weld chain bucket)
```

```lisp
(...)
```

...we still aren't in the right situation to do any welding, but the command is doing its job!


![](../images/dunk.jpg)


Next, let's rewrite the ``dunk`` command as well:

```lisp
(...)
```

Notice how the ``weld`` command had to check whether we have the subject, but that the ``dunk`` command skips that step -- our new ``game-action`` SPEL makes the code easy to write and understand.

![](../images/splash.jpg)

And now our last code for splashing water on the wizard:


```lisp
(...)
```
