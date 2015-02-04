## Making the Game Map

Here's a refresher on our locations:

![](../images/world.jpg)

Now we can combine the data we have defined to finally make our world state!

```lisp
> (set state (make-state
               objects objects
               places (list living-room garden attic)
               player 'living-room))
```
```lisp
#(state
  (#(object whiskey-bottle living-room)
   #(object bucket living-room)
   #(object frog garden)
   #(object chain garden))
  (#(place living-room
     "You are in the living-room of a wizard's house. There is a wizard snoring loudly on the couch."
     (#(exit "west" "door" garden) #(exit "upstairs" "stairway" attic)))
   #(place garden
     "You are in a beautiful garden. There is a well in front of you."
     (#(exit "east" "door" living-room)))
   #(place attic
     "You are in the attic of the wizard's house. There is a giant welding torch in the corner."
     (#(exit "downstairs" "stairway" living-room))))
  living-room)
```

This state contains everything important that we'd like to know about:

 * the objects in the game and their locations
 * the player location
 * the places in the game

Notice how information-rich this one variable is and how it describes all we need to know but not a thing more. Lispers love to create small, concise pieces of code that leave out any fat and are easy to understand just by looking at them.

Now let's begin making some game commands!

![](images/drink.jpg)
