# Goals

We're going to have a couple of puzzles in our game and a final task to accomplish, once these puzzles are solved. Let's define the goal record:

```lisp
(defrecord goal
  name
  achieved?)
```

Now the goals:

```lisp
lfe> (set goals
    (list (make-goal name 'weld-chain achieved? 'false)
          (make-goal name 'dunk-bucket achieved? 'false)
          (make-goal name 'splash-wizard achieved? 'false)))
```
```lisp
(#(goal weld-chain false)
 #(goal dunk-bucket false)
 #(goal splash-wizard false))
```

Now that we have our records, let's put them together!
