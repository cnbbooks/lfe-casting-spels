## Making the Game Map

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

Now we can finally define a new variable called ``*map*`` that combines these together to give us a picture of our mini-world:

```lisp
> (set *map* (make-map
               living-room living-room
               garden garden
               attic attic))
```
```
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

Now that we have a map and a bunch of objects, it makes sense to create another variable that says where each of these object is on the map:

```lisp
> (set *object-locations* '(#(whiskey-bottle living-room)
                            #(bucket living-room)
                            #(chain garden)
                            #(frog garden)))
```
```lisp
(#(whiskey-bottle living-room)
 #(bucket living-room)
 #(chain garden)
 #(frog garden))
```

Here we have associated each object with a location. A list of *tuples* like this is called a *property list* in LFE. A *property list* is simply a list of *tuples* where the first item in each *tuple* is a "key" *atom* that is associated with a bunch of other data (the "value").

Now that we have defined our world and the objects in the world, the only thing left to do is describe the location of the player of the game:

```lisp
> (set *location* 'living-room)
```
```lisp
living-room
```

Now let's begin making some game commands!

![](images/drink.jpg)
