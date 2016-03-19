## The Problem of State

As a functional language, LFE doesn't let you (easily or cleanly) set global state within functions. (This is something that experienced programmers are quite grateful for!) As such, we've had to learn how to pass the game state around to different functions which needed access to that data. Our data may be nice and clean (hooray!), but the effect this has had on the game play is rather awful, to be honest.

Do you think there's a way that we could both *pass state data to functions* and *keep the game interface uncluttered*?

We won't keep you in suspense: yes, there is! There are some key ingredients needed for this:

* we need some place to "hide" the state
* wherever we "hide" the state, we need to be able to tell it when to change
* we need to be able to easily retrieve the state from its hiding place

Thinking about this is almost as tricky as creating SPELs ... so let's take it one step at a time.
