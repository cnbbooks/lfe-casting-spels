# Places and Exits

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
