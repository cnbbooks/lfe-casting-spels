## Global State

Many languages allow for something called *global variables*. The LFE REPL has partial support for this -- you did it when you created the ``objects`` variable earlier.

What does it *mean*, though?

For example, if you have a global variable, you can access it from a function. We could have defined our ``cccr`` function like this, to take advantage of the global variable ``objects``:

```lisp
> (defun cccr ()
    (car (cdr (cdr objects))))
```

The function doesn't define something called ``objects`` and it doesn't receive something called ``objects`` via a function argument. So it's *accessing* the global variable. Some languages will also let you *change* the value of global variables. Conversely, other consider this an *anti-pattern* (something you shoulnd't do) and either discourage it our out-right prevent it.

LFE is one of the latter: you can't change a global variable from inside a function (unless you do some seriously crazy things to your code ... it *is* a Lisp, after all, so even some impossible things are possible!). LFE does allow you to *shadow* global variables, but that won't change the original (*shadowing* just covers it up temporarily).

When writing a simple game or modeling objects, global state is an easy thing to use for new-comers. Common Lisp supports this easily. However, in LFE this isn't an option. We're going to have to dive a little deeper for an alternative, and so our game won't be quite as simple as it might have been if we wrote it in Common Lisp or Python. But since LFE is a language for writing distributed systems, you are probably interested in avoiding global state anyway!

So, buckle your seat-belt: before adventure time, we're gonna do some learnin'!
It's okay, though -- it'll be fun :-)
