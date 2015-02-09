## Organizing Things with Records

### Making a Plan

As we've said, our game is going to need the following:

* objects
* places
* place data (description, exits)
* object locations
* player location

We need to create a data structure to hold all of that, so that it can be passed to function which need one or more bits of that data. As we mentioned when we talked about Non-Global State, The data structure we're going to use is the LFE *record*. A *record* is a simple data structure that lets us associate keys and values.

Let's attack this problem in pieces; we can start with the big picture, and then fill that in.

### Game State

Let's create the over-arching record definition for our game state:


```lisp
(defrecord state
  objects
  places
  player
  goals)
```

We've just defined a record called ``state`` that has three fields: ```objects``, ``places``, and ``player``.


### Objects

For each object in the game, we need to know its name and location:

```lisp
(defrecord object
  name
  location)
```

Let's create some objects now, improving upon our initial "objects" exploration:

```lisp
> (set objects
    (list (make-object name 'whiskey-bottle location 'living-room)
          (make-object name 'bucket location 'living-room)
          (make-object name 'frog location 'garden)
          (make-object name 'chain location 'garden)))
```
```lisp
(#(object whiskey-bottle living-room)
 #(object bucket living-room)
 #(object frog garden)
 #(object chain garden))
```

You are probably wondering where that mysterious ``make-object`` function came from. When you create a record in LFE, LFE creates several functions dynamically, just for use with your record: their names start with or have as part of their own names, the record name you used. For example, when you created the ``state`` and ``object`` records, LFE created the ``make-state`` and ``make-object`` functions (among several others -- more later).


### Places and Exits

Now that we've defined some objects in our world, we're on our way towards describing our world. But there's more to go, still. Our next goal is to create a record for our places:

```lisp
(defrecord place
  name
  description
  exits)
```

Great! Now we can define our places ... almost. What's the "exit" business? Well, if we're going to move about from place to place, we need to know what direction to go in, the object that lets us pass from one location to the next, and the final destination. Let's create another record for this data:

```lisp
(defrecord exit
  direction
  object
  destination)
```

*Now* we're ready to create our places!

```lisp
> (set living-room
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

As you can see above, we have records being created inside records: the ``living-room`` record has two exits in it, and we just created those ``exit`` records when created the living room's ``place`` record.

Something else new: the ``++`` function. This is the function for combining two lists in LFE, and since strings and lists are actually the same exact data type, it's also what you use to concatenate strings.

Three more to go!

```lisp
> (set garden
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
> (set attic
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
> (set netherworld
    (make-place
      name 'netherworld
      description (++ "Everything is misty and vague. "
                      "You seem to be in the netherworld.\n"
                      "There are no exits.\n"
                      "You could be here for a long, long time ...")
      exits '()))
```


This may seem like a lot of overhead, but it means that things will be much
cleaner and less suseptible to bugs: each item of data is well-defined, with functions that create the data, access the data, and update the data -- both the "magical" record functions mention above as well as functions defined in the Erlang standard library (e.g., the ``proplists`` and ``orddict`` modules).

Furthermore, this is a common practice used in many real-world Erlang and LFE applications: records are passed as inputs to functions and returned as (often updated) outputs, which in turn are fed into other functions.


### Goals

We're going to have a couple of puzzles in our game and a final task to accomplish, once these puzzles are solved. Let's define the goal record:

```lisp
(defrecord goal
  name
  achieved?)
```

Now the goals:

```lisp
> (set goals
    (list (make-goal name 'weld-chain achieved? 'false)
          (make-goal name 'fill-bucket achieved? 'false)
          (make-goal name 'splash-wizard achieved? 'false)))
```
```lisp
(#(goal weld-chain false)
 #(goal fill-bucket false)
 #(goal splash-wizard false))
```

Now that we have our records, let's put them together!
