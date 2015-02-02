# Casting SPELs in Lisp

*The LFE Edition*

Anyone who has ever learned to program in Lisp will tell you it is very different from any other programming language. It is different in lots of surprising ways- This comic book will let you find out how Lisp's unique design makes it so powerful!

![](book/images/different.jpg)

This tutorial has small bits of Lisp code that are presented as it looks
when using the LFE REPL (the "interactive interpreter"). The LFE prompt looks
like this:

```lisp
>
```

Code entered in the REPL looks like this:

```lisp
> (+ 1 1)
```
```lisp
2
```

Results will come right afterwards, in their own text block, just like you saw in
that example just now.

When you copy the code from this book into your own LFE REPL, be sure
not to copy the ``>`` prompt! Just copy the code :-)

What will you be copying, you ask? A-ha! This is the best part: **your own text
adventure game!**

First, though, we're going to have to cover some basics. But take heart: you'll be coding up some gamey goodness in no time ;-)


## What is LFE?

LFE stands for "Lisp Flavoured Erlang". It's a Lisp dialect written on top of
the Erlang Virtual Machine (also known as the "BEAM"). Erlang syntax looks
like this:

```erlang
factors(N) ->
     factors(N,2,[]).

factors(1,_,Acc) -> Acc;
factors(N,K,Acc) when N rem K == 0 ->
    factors(N div K,K, [K|Acc]);
factors(N,K,Acc) ->
    factors(N,K+1,Acc).
```

LFE syntax looks like this:

```lisp
(defun factors (n)
  (factors n 2 '()))

(defun factors
  ((1 _ acc)
    acc)
  ((n k acc) (when (== 0 (rem n k)))
    (factors (div n k) k (cons k acc)))
  ((n k acc)
    (factors n (+ k 1) acc)))
```

You don't need to worry about that code or what it means: it's just there to
give you a "feel" of the code, a visual sense of how the two languages are
the same underneath, but superficially different (we'll be discussing syntax
very shortly!)

If you don't have LFE installed on your computer, no need to worry -- in the first chapter, you will be setting up LFE so that you can follow along
in this book.


## About

This Gitbook (available [here](http://lfe.gitbooks.io/casting-spels/))
is a work in progress, converting Dr. Conrad Barski's original Common Lisp
[comic book adventure game](http://www.lisperati.com/casting.html) to Lisp
Flavoured Erlang. It was very kind of Dr. Barski to share his work with the
Lisp community licensed as GNU Free Documentation, thus allowing others to
adopt it for their own preferred language.

Other editions of the book include:
 * [Clojure](http://www.lisperati.com/clojure-spels/casting.html)
 * [Emacs Lisp](http://www.lisperati.com/casting-spels-emacs/html/casting-spels-emacs-1.html)


## Contributing

If you found a bug, typo, inconsistency, etc., fee free to open a ticket or
even submit a pull request!

* [Create a ticket](https://github.com/lfe/sicp/issues/new).
