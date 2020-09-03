# LFE Syntax Walkthrough

Once in the REPL, load up the game commands:

```lisp
> (include-lib "spels/include/commands.lfe")
loaded-game-commands
```

At this point, you are ready to play!


Here's a walk-through:

```lisp
> (look)
ok
>
You are in the living-room of a wizard's house. There is a wizard snoring
loudly on the couch.
You see a whiskey-bottle on the ground. You see a bucket on the ground.
There is a door going west from here. There is a stairway going upstairs from
here.
> (take 'bucket)
ok
>
You are now carrying the bucket.
> (go west)
ok
>
You are in a beautiful garden. There is a well in front of you.
You see a frog on the ground. You see a chain on the ground.
There is a door going east from here.
> (take chain)
ok

You are now carrying the chain.
> (go east)
ok

You are in the living-room of a wizard's house. There is a wizard snoring
loudly on the couch.
There is a door going west from here. There is a stairway going upstairs from
here.
> (go upstairs)
ok

You are in the attic of the wizard's house. There is a giant welding torch in
the corner.
There is a stairway going downstairs from here.
> (weld chain bucket)
ok
>
You have achieved the 'weld-chain' goal!

The chain is now securely welded to the bucket.
(look)
ok

You are in the attic of the wizard's house. There is a giant welding torch in
the corner.
There is a stairway going downstairs from here.
> (go downstairs)
ok

You are in the living-room of a wizard's house. There is a wizard snoring
loudly on the couch.
There is a door going west from here. There is a stairway going upstairs from
here.
> (go west)
ok

You are in a beautiful garden. There is a well in front of you.
You see a frog on the ground.
There is a door going east from here.
> (dunk bucket well)
ok

You have achieved the 'dunk-bucket' goal!

The bucket is now full of water.
> (go east)
ok

You are in the living-room of a wizard's house. There is a wizard snoring
loudly on the couch.
There is a door going west from here. There is a stairway going upstairs from
here.
> (splash wizard bucket)
ok

You have achieved the 'splash-wizard' goal!

The wizard awakens from his slumber, greets you warmly, and thanks you for
pulling him out of a rather nasty dream.
Your reward, it seems, is a magical low-carb donut which he hands you ...
right before drifting off to sleep again.

You won!!
```
