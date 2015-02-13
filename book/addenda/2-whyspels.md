## The Case Against the Word "Macro"

Part of the purpose of writing this tutorial is to experiment with ways that can tackle the difficult subject of *true macros* in Lisp. Often, when I try to explain the concept of macros to somebody who has only used other languages, I'll get a response like "Oh yeah! There's macros like that in C++, too!". The moment this happens, it becomes very difficult to explain "true macros", because of the semantic load on the word "macro". After all, "true macros" *really are* a lot like C++ macros, in that they are a way to talk to the compiler with modified code...

...so imagine if John McCarthy had used the word "add" instead of "cons" to connect items to lists: It would make it really difficult to explain how consing works.

Therefore, I decided to experiment with a new term for a macro in this essay: SPEL, which stands for "Semantic Program Enhancement Logic", which is admittedly a bit of a stretch, but the term has many benefits:

1. It captures the almost magical power that Lisp macros can have to change the behavior of a Lisp environment.
1. The term SPEL can be used in a million different ways to explain programming concepts in elegant ways, using the metaphor of the *spell* and *casting spells*.
1. The term causes no confusion between true macros and other types of macros.
1. The semantic load of the term "spel" is very low. A Google search for "(macro OR macros) programming -lisp -scheme" return 1150000 hits. A Google search for "(spel OR spels) programming -lisp -scheme" return only 28400. Even worse when you consider that the search "(macro OR macros) programming (lisp OR scheme)" only returns a measly 395000!

So I hope, as a Lisper, you'll consider supporting this new term. Naturally, any new memes like this have a very low likelihood of success.

If you have a library or are a Lisp implementation author, **please drop everything you are doing right now** and add the following line to your library:

```lisp
(defmacro defspel (&rest rest) `(defmacro ,@rest))
```

There, problem solved!

:)

-- Conrad Barski, M.D.
