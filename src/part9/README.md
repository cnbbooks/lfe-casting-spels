## Production-Quality Game: Using OTP

Throughout the book, we avoided the fairly complicated topic of OTP (the means by which you can write fault-tolerant, production-ready applications in LFE). There are several great resources to learn of OTP (as provided at the end of the book), but we couldn't just leave it at that. No, it felt negligent to show readers how to create a simple game server -- which, if used in production, would cause endless heartache -- and _not_ show they how to do it "properly".

Thus, for the motivated reader, we include here a version of the game converted to LFE/OTP. An explanation of this code and what it does is beyond the scope of this mini-book, but there are plenty of good books where you can read about Erlang/OTP (and blog posts where you can read about LFE/OTP!) and then apply that to what you've learned here, using the LFE/OTP game code to extend your knowledge.

The OTP version of the game is available in the `code` directory. If you haven't clonsed the book's repo already, be sure to do that now. All you need to do is follow the instructions as detailed in the "Getting Started" section titled "Project Space."

If you followed those directions, and the steps in the next session about starting the REPL, then you'll have already generated a release for the code and will have started the REPL.

When you started the REPL, you would have seen messages like the following:
```lisp
lfe>
===> Booted compiler
===> Booted lfe
===> Booted spels
===> Booted sasl
```

The messages you saw after starting the REPL had to do with applications booting up. This is due to the game code running as an OTP release, essentially a production-ready set of applications, complete with a supervision tree for our game server!

In fact, you can check to see if the supervisor is running with the following:

```lisp
lfe> (erlang:whereis 'spels-sup)
#Pid<0.247.0>
```

Since this is a release application, the game server will already have been started after the REPL came up. (Yeah, this whole time it has been running!) You can confirm this by calling a function in the game server's API:

```lisp
lfe> (spels-game:look)
```

```text
You are in the living-room of a wizard's house. There is a wizard snoring
loudly on the couch.
You see a whiskey-bottle on the ground. You see a bucket on the ground.
There is a door going west from here. There is a stairway going upstairs from
here.
ok
```

But! We want to be able to use the short-hand versions of the commands, so let's load those:

```lisp
lfe> (include-lib "spels/include/commands.lfe")
loaded-game-commands
```

This version of the game has some help text we can view with the `(help)` function that was just loaded:
```lisp
(help)

You are not in a maze, there are no twisty passages, and everything
is pretty much not the same.

You are not, however, witout aid. Here are the available commands:

  (dunk SUB OBJ)   - Dunk one item in another.
  (go DIR)         - Move in a particular direction. Valid values for
                     DIR: east, west, north, south.
                     Command alias: move
  (exits)          - List the exits availble to the player from the
                     current location.
  (help)           - Display this help text.
  (inv)            - List the items currently in the player's
                     possession.
  (look)           - Examine the surroundings.
                     Command aliases: describe, desc
  (quit)           - Quit the game.
  (splash SUB OBJ) - Splash something with another thing.
  (start)          - Start the game server.
  (stop)           - Stop the game server.
  (take ITEM)      - Take possession of the given item. Valid values
                     for ITEM are the items described when (look)ing.
                     Command aliases: get, pickup
  (weld SUB OBJ)   - Weld two things together.

ok
```

With the commands loaded, you're ready to play the game:

![](../images/world.jpg)

```lisp
lfe> (look)
ok
lfe>
You are in the living-room of a wizard's house. There is a wizard snoring
loudly on the couch.
You see a whiskey-bottle on the ground. You see a bucket on the ground.
There is a door going west from here. There is a stairway going upstairs from
here.
```

![](../images/living_room.jpg)

```lisp
lfe> (go west)
ok
lfe>
You are in a beautiful garden. There is a well in front of you.
You see a frog on the ground. You see a chain on the ground.
There is a door going east from here.
lfe> (take chain)
ok

You are now carrying the chain.
lfe> (go east)
ok
```
![](../images/slob.jpg)
```lisp
You are in the living-room of a wizard's house. There is a wizard snoring
loudly on the couch.
You see a whiskey-bottle on the ground. You see a bucket on the ground.
There is a door going west from here. There is a stairway going upstairs from
here.
lfe> (take bucket)
ok
lfe>
You are now carrying the bucket.
lfe> (go upstairs)
ok

You are in the attic of the wizard's house. There is a giant welding torch in
the corner.
There is a stairway going downstairs from here.
```
![](../images/weld.jpg)
```lisp
lfe> (weld chain bucket)
ok
lfe>
You have achieved the 'weld-chain' goal!

The chain is now securely welded to the bucket.

lfe> (go downstairs)
ok

You are in the living-room of a wizard's house. There is a wizard snoring
loudly on the couch.
There is a door going west from here. There is a stairway going upstairs from
here.
lfe> (go west)
ok

You are in a beautiful garden. There is a well in front of you.
You see a frog on the ground.
There is a door going east from here.
```

![](../images/dunk.jpg)

```lisp
lfe> (dunk bucket well)
ok

You have achieved the 'dunk-bucket' goal!

The bucket is now full of water.
lfe> (go east)
ok

You are in the living-room of a wizard's house. There is a wizard snoring
loudly on the couch.
There is a door going west from here. There is a stairway going upstairs from
here.
```
![](../images/splash.jpg)
```lisp
lfe> (splash wizard bucket)
ok

You have achieved the 'splash-wizard' goal!

The wizard awakens from his slumber, greets you warmly, and thanks you for
pulling him out of a rather nasty dream.
Your reward, it seems, is a magical low-card donut which he hands you ...
right before drifting off to sleep again.

You won!!
```
![](../images/donut.jpg)
