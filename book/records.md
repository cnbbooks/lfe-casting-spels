## Organizing Things with Records

Now that we've defined some objects in our world, we're on our way towards describing our world. But there's more to go, still. Our goal is to represent or game world with a map. Here is a picture of what our world looks like:

![](images/world.jpg)

In this simple game, there will only be three different locations: A house with a living room and an attic, along with a garden. We're going to describe each of these, as well as provide metadata associated with them. We'll do that with something called a "record", a simple data structure in Erlang and LFE that lets us associate keys and values. Let's create a record for our places:

```lisp
> (defrecord place
    description
    exits)
```
```lisp
()
```

Great! Now we can define our places ... almost. What's the "exit" business? Well, if we're going to move about from place to place, we need to know what direction to go in, the object that lets us pass from one location to the next, and the final destination. Let's create another record for this data:

```lisp
> (defrecord exit
    direction
    object
    destination)
```
```lisp
()
```

Now we're ready to create our places!

```lisp
> (set living-room
    (make-place
      description (++ "You are in the living-room of a wizard's house. "
                      "There is a wizard snoring loudly on the couch.")
      exits (list
              (make-exit
                direction "west"
                object "door"
                destination 'garden)
              (make-exit
                direction "upstairs"
                object "stairway"
                destination 'attic))))
```
```lisp
#(place
  "You are in the living-room of a wizard's house. There is a wizard snoring loudly on the couch."
  (#(exit west door garden) #(exit upstairs stairway attic)))
```

Two more to go!

```lisp
> (set garden
    (make-place
      description (++ "You are in a beautiful garden. "
                      "There is a well in front of you.")
      exits (list
              (make-exit
                direction "east"
                object "door"
                destination 'living-room))))
```
```lisp
#(place
  "You are in a beautiful garden. There is a well in front of you."
  (#(exit east door living-room)))
```
```lisp
> (set attic
    (make-place
      description (++ "You are in the attic of the wizard's house. "
                      "There is a giant welding torch in the corner.")
      exits (list
              (make-exit
                direction "downstairs"
                object "stairway"
                destination 'living-room))))
```
```lisp
#(place
  "You are in the attic of the wizard's house. There is a giant welding torch in the corner."
  (#(exit downstairs stairway living-room)))
```

This may seem like a lot of overhead, but it means that things will be much
cleaner and less suseptible to bugs: each item of data is well-defined, with functions that create the data, access the data -- both the magical record functions as well as functions in the Erlang standard library.

Furthermore, this is a common practice used in many real-world Erlang and LFE applications: records are passed as inputs to functions and returned as (often updated) outputs, which in turn are fed into other functions.

Now that we have our records, let's put them together!
