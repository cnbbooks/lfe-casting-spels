## Introducing Functions

As you write more Lisp, you're going to find yourself writing a lot of functions. Before we write one, though, let's call some!

```lisp
> (car objects)
whiskey-bottle
```

The ``car`` function is one of the oldest functions in Lisp (some modern Lisps no longer define it) and it gets its name from manipulating memory registers (originally on the old IBM 704, which was used to create Lisp!). ``car`` gets the first element of a list. It has a complement, ``cdr``:

```lisp
> (cdr objects)
(bucket frog chain)
```

``cdr`` gets the rest of a list. Let's do some more:

```lisp
> (cdr (cdr objects))
(frog chain)
> (car (cdr (cdr objects)))
frog
```

Ignoring the fact that there's a function which defines this exact behaviour, let's define our own which caputes this playful exploration:

```lisp
> (defun cccr (objs)
    (car (cdr (cdr objs))))
cccr
```

In Lisp, ``defun`` lets us define a function which we can call later. A function definition has several key parts:

* the call to ``defun``
* a name for the function
* the arguments that the function will accept when we call it later (in this case, we only have one argument, ``objs``)
* the function body

Notice that we defined what is called a *local variable* in that function. This means that the ``objs`` variable will only be accessible *inside the function itself*.

Let's try it out:

```lisp
> (cccr objects)
frog
```

That's much easier to type! (For the curious, Common Lisp and LFE define the function ``caddr`` which does the same as ``(car (cdr (cdr ...))))``.)

Note that functions in Lisp are often more like functions in math than in other programming languages: Just like in math, this function doesn't print stuff for the user to read or pop up a message box. All it does is return a value as a result of the function.

In LFE, there are all sorts of ways to create functions, so be prepared -- you're going to see some different ways soon!
