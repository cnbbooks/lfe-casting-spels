## Making the Game Map

Here's a refresher on our locations:

![](../images/world.jpg)

Now we can combine the data we have defined to finally make our game map! Except ... we need another record. But that's easy enough to fix: we'll do like we did before, using the three places we know we need:

```lisp
> (defrecord map
    living-room
    garden
    attic)
```
```
()
```

Now we can finally define a new variable called ``game-map`` that combines these together to give us a picture of our mini-world:

```lisp
> (set map (make-map
             living-room living-room
             garden garden
             attic attic))
```
```lisp
#(map
  #(place
    "You are in the living-room of a wizard's house. There is a wizard snoring loudly on the couch."
    (#(exit "west" "door" garden) #(exit "upstairs" "stairway" attic)))
  #(place
    "You are in a beautiful garden. There is a well in front of you."
    (#(exit "east" "door" living-room)))
  #(place
    "You are in the attic of the wizard's house. There is a giant welding torch in the corner."
    (#(exit "downstairs" "stairway" living-room))))
```

This map contains everything important that we'd like to know about our three locations: a unique name for the location (i.e. "living room", "garden", and "attic") a short description of what we can see from there, plus the where and how of each path into/out of that place. Notice how information-rich this one variable is and how it describes all we need to know but not a thing more. Lispers love to create small, concise pieces of code that leave out any fat and are easy to understand just by looking at them.


We have defined our world map and the objects in the world. We can start putting things together for the complete game state. Let's create that now:

```lisp
> (set state (make-state
               objects objects
               places map
               player 'living-room))
```
```lisp
#(state
  (#(object whiskey-bottle living-room)
   #(object bucket living-room)
   #(object frog garden)
   #(object chain garden))
  #(map
    #(place
      "You are in the living-room of a wizard's house. There is a wizard snoring loudly on the couch."
      (#(exit "west" "door" garden) #(exit "upstairs" "stairway" attic)))
    #(place
      "You are in a beautiful garden. There is a well in front of you."
      (#(exit "east" "door" living-room)))
    #(place
      "You are in the attic of the wizard's house. There is a giant welding torch in the corner."
      (#(exit "downstairs" "stairway" living-room))))
  living-room)
```

The only player data we are going to track is the location, so we don't really need a ``player`` record.

Now let's begin making some game commands!

![](images/drink.jpg)
