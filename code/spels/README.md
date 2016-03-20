# Casting SPELs with LFE

*The OTP Version*

Start the LFE REPL (which will first compile all the modules):

```bash
$ make repl
```

Once in the REPL, start the game server and then load up the game commands:

```lisp
Erlang/OTP 17 [erts-6.2] [source] [64-bit] [smp:4:4] [async-threads:10]

   ..-~.~_~---..
  (      \\     )    |   A Lisp-2+ on the Erlang VM
  |`-.._/_\\_.-';    |   Type (help) for usage info.
  |         g (_ \   |
  |        n    | |  |   Docs: http://docs.lfe.io/
  (       a    / /   |   Source: http://github.com/rvirding/lfe
   \     l    (_/    |
    \   r     /      |   LFE v1.0 (abort with ^G)
     `-E___.-'

> (spels-game:start)
#(ok <0.36.0>)
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
Your reward, it seems, is a magical low-card donut which he hands you ...
right before drifting off to sleep again.

You won!!
```
