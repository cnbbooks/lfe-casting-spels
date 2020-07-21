# What is LFE?

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
give you a "feel" of these two Erlang syntaxes (LFE in particular!), a visual
sense of how the two languages are the same underneath, but superficially
different (we'll be discussing syntax very shortly!)

If you don't have LFE installed on your computer, no need to worry -- in the first chapter, you will be setting up LFE so that you can follow along
in this book.
