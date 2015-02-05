## Interacting

Now we'll create a command to pickup objects in our world. We'll need some helper functions for this:

1. Change the location of an object (from the room to the player)



```lisp

```


```lisp
(defspel pickup (object-name game-state)
  `(pickup-object ',object ,game-state))
```
```lisp
()
```
