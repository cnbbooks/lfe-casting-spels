## Losing Play-Through

Now, for the morbidly curious, here's what a losing scenario might look like, starting from when you're in the garden:

```lisp
(take chain)
------------------------------------------------------------------------------
>
You are now carrying the chain.
(take frog)
------------------------------------------------------------------------------
>
You are now carrying the frog.
```

You then perform all the other tasks that you would do in the winning scenario. Finally, you are ready to wake the wizard:

```lisp
(inv)
------------------------------------------------------------------------------
>
You are carrying the following:
 - bucket
 - frog
 - chain
(splash wizard bucket)
------------------------------------------------------------------------------
>
You have achieved the 'splash-wizard' goal!

The wizard awakens to see that you are in possession of his most precious --
and dangerous! -- frog.
He completely looses it.
As he waves his wand at you, everything disappears ...
```

Wondering what happend, you take a look around:

```lisp
(look)
------------------------------------------------------------------------------
>
Everything is misty and vague. You seem to be in the netherworld.
There are no exits.
You could be here for a long, long time ...
```

Nothing happens. You look some more:

```lisp
(look)
------------------------------------------------------------------------------
>
Everything is misty and vague. You seem to be in the netherworld.
There are no exits.
You could be here for a long, long time ...
```

Again, nothing. Another try ...

```lisp
(look)
------------------------------------------------------------------------------
>
Everything is misty and vague. You seem to be in the netherworld.
There are no exits.
You could be here for a long, long time ...
```

And as you're wondering what's going on, after a few seconds, you see this:

```lisp
From deep in the mists, you hear a familiar intonation ...
Great relief washes over you, as you recognize the time-travel spell -- you're
not doomed!
```

After a few more seconds you see this:

```lisp
Confident that you will never pick up the frog again, things get a bit fuzzy.
You start to lose consciousness as the wizard pulls you back in time. Your
last thought is that you're probably not going to remember any of this ...
```

Finally, you are back where you started:

```lisp
You are in the living-room of a wizard's house. There is a wizard snoring
loudly on the couch.
You see a whiskey-bottle on the ground. You see a bucket on the ground.
There is a door going west from here. There is a stairway going upstairs from
here.
```

Now you have the chance to play the game again, but this time without taking the power-frog!
