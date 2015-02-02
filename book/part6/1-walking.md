# Walking Around In Our World

Ok, now that we can see our world, let's write some code that lets us walk around in it. The function ``walk-direction`` (not in the functional style) takes a direction and lets us walk there:

```lisp
(defun walk-direction (direction)
  (let ((next (assoc direction (cddr (assoc *location* *map*)))))
    (cond (next (setf *location* (third next)) (look))
      (t '(you cant go that way.)))))
```
