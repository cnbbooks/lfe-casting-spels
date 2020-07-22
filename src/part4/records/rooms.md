# Rooms

Now that we have an abstract definition of a place, and a means of entering that place and ulimately leaving that place, we can create some concrete examples of those. Some will be inside, some outside -- but we'll call them all "rooms" for now ;-)

```lisp
lfe> (set living-room
    (make-place
      name 'living-room
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
#(place living-room
  "You are in the living-room of a wizard's house. There is a wizard snoring loudly on the couch."
  (#(exit "west" "door" garden) #(exit "upstairs" "stairway" attic)))
```

As you can see above, we have records being created inside records: the `living-room` record has two exits in it, and we just created those `exit` records when created the living room's `place` record.

Something else new: the `++` function. This is the function for combining two lists in LFE, and since strings and lists are actually the same exact data type, it's also what you use to concatenate strings.

Three more to go!

```lisp
lfe> (set garden
    (make-place
      name 'garden
      description (++ "You are in a beautiful garden. "
                      "There is a well in front of you.")
      exits (list
              (make-exit
                direction "east"
                object "door"
                destination 'living-room))))
```

```lisp
#(place garden
  "You are in a beautiful garden. There is a well in front of you."
  (#(exit "east" "door" living-room)))
```

```lisp
lfe> (set attic
    (make-place
      name 'attic
      description (++ "You are in the attic of the wizard's house. "
                      "There is a giant welding torch in the corner.")
      exits (list
              (make-exit
                direction "downstairs"
                object "stairway"
                destination 'living-room))))
```

```lisp
#(place attic
  "You are in the attic of the wizard's house. There is a giant welding torch in the corner."
  (#(exit "downstairs" "stairway" living-room)))
```

```lisp
lfe> (set netherworld
    (make-place
      name 'netherworld
      description (++ "Everything is misty and vague. "
                      "You seem to be in the netherworld.\n"
                      "There are no exits.\n"
                      "You could be here for a long, long time ...")
      exits '()))
```
