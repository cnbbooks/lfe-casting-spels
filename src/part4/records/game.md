# Game State

Let's create the over-arching record definition for our game state:

```lisp
(defrecord state
  objects
  places
  player-location
  goals)
```

We've just defined a record called `state` that has four fields: `objects`, `places`, `player-location`, and `goals`. We're going to need records for each of those, too!
