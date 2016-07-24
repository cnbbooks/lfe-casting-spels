## A Glance at Closures

The solution we have proposed is to "hide" the state data -- but how do we do that? Well, if there was a way to capture the data in a variable, and then have that variable available for querying or updating, we'd be in luck. Fortunately, there is and we are :-)

Thanks to something called *closures*. The term *closure* was coined in 1964 and then made widely popular by the creators of a Lisp called *Scheme* in 1975. Let's see what a closure looks like, and then maybe we can make better sense of the name.

Here's one example:

```lisp
(defun a-closure (state)
  (lambda () state))
```

What we have above is:

1. A function definition that takes a single variable, and
1. Returns a *separate* function which *has access to* that passed argument.

When we call our ``a-closure`` function, we're going to get another function (not a value). Magically, when we call this returned function, we're going to see whatever data was passed as the ``state`` argument.

Let's try that out in the REPL:

```lisp
> (set x (a-closure "here's my state!"))
#Fun<lfe_eval.23.101079464>
```
(Wait for a year.)

```lisp
> (funcall x)
"here's my state!"
```

So, long after we called the function ``a-closure``, we called another function, *and got the data that was passed to the original function*. One way of describing this is that the ``state`` variable was "bound in" or "closed" in the environment of the ``a-closure`` function -- thus the name!

So, we've done something that *might* seem pretty cool ... but maybe not? It's a little hard to tell. Let's try a bit bigger example to see if it *is* cool, and more importantly, if it might help us with our game.

Let's try writing a closure whose state tracks the balance of greetings:

```lisp
(defun state-holder (state)
  (lambda (msg)
    (case msg
      ('hi
        (+ state 1)))))
```

Let's set up our state with an initial value of ``0``:

```lisp
> (set sh (state-holder 0))
```
```lisp
#Fun<lfe_eval.12.101079464>
```

Unlike our first, super-simple example, the ``lambda`` in the ``state-holder`` example takes an argument. But not any old argument! It can only be ``'hi``. Let's try it out on our ``state-holder`` variable:

```lisp
> (funcall sh 'hi)
1
> (funcall sh 'hi)
1
> (funcall sh 'hi)
1
```

Hrm ... we get the same result. When we think about it, that makes sense: we only bound our state variable once, when we called the ``state-holder`` function. Let's try it again:

```lisp
(defun state-holder (state)
  (lambda (msg)
    (case msg
      ('hi
        (state-holder (+ state 1))))))
```

Since we're returning a new closure for the updated state, we'll want to capture it -- so we'll re-set the ``sh`` variable with each call. We'll start by calling the function we've defined:

```lisp
> (set sh (state-holder 0))
#Fun<lfe_eval.12.101079464>
```

What has just been saved in the ``sh`` variable is the *output* of the ``state-holder`` function, an anonymous function which takes a message as a parameters. Let's call this returned function repeatedly, resetting the output each time so that we keep track of the updated state:

```lisp
> (set sh (funcall sh 'hi))
#Fun<lfe_eval.12.101079464>
> (set sh (funcall sh 'hi))
#Fun<lfe_eval.12.101079464>
> (set sh (funcall sh 'hi))
#Fun<lfe_eval.12.101079464>
```

Well, *maybe* that's better -- we just can't tell. We keep getting the new closure back. How can we get a look at the current state? We could add a new message type ...

```lisp
(defun state-holder (state)
  (lambda (msg)
    (case msg
      ('hi
        (state-holder (+ state 1)))
      ('amount?
        state))))
```

Let's try this out:

```lisp
> (set sh (state-holder 0))
#Fun<lfe_eval.12.101079464>
> (set sh (funcall sh 'hi))
#Fun<lfe_eval.12.101079464>
> (set sh (funcall sh 'hi))
#Fun<lfe_eval.12.101079464>
> (funcall sh 'amount?)
2
> (set sh (funcall sh 'hi))
#Fun<lfe_eval.12.101079464>
> (funcall sh 'amount?)
3
```

Hey, look at that! We've got something pretty cool happening: the internal workings and representation of the state are hidden away. When we want to change things, we just need to send the right message and then rebind our ``sh`` variable to the updated ``state-holder``. The down side is that we're seeing the closure data (the output of ``#Fun<lfe_eval.12.101079464>``). But maybe there's a way around that?

There is :-) But we're going to have to go a little further down the rabbit hole ...
