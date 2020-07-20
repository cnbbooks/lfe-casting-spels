## Light-weight Processes as Closures

We've looked at classic Lisp closures, and now we're going to look at something completely different ... that's almost the same thing! 

LFE runs on the Erlang Virtual Machine, and Erlang is *famous* for its "light-weight processes". It turns out that we can use these processes in a way that is very similar to closures. To take advantage of this, we will need a couple of parts:

* a state-holder function
* something that starts our initial state-holder "process"
* a name for our state-holder "process"
* something that stops our state-holder "process"

Here's what something like these might look like:

```lisp
(defun state-holder (state)
  (receive
    ('hi
      (state-holder (+ 1 state)))
    ('amount?
      (io:format "Current state: ~p~n" (list state))
      (state-holder state))))

(defun state-holder ()
  (state-holder 0))

(defun start ()
  (let ((sh-pid (spawn #'state-holder/0)))
    (register 'our-proc sh-pid)))

(defun stop ()
  (exit (whereis 'our-proc) 'done))
```

See that ``receive`` call? That's like the ``lambda`` in the previous example that was creating our closure. Just like we could ``send`` messages to that ``lambda``, we can *really* send message to the ``receive``.

As you can see, to start things off, we are going to "spawn" a function as its own tiny little process (these are nothing like operating system processes!). And then we are going to send messages to it -- kinda like our closures. We'll use the special "send" function, though: ``(! ...)`` And we'll use the ``(whereis ...)`` function to look up our spawned process id. Wanna try it out?

Start by pasting the code about into your LFE REPL. Then, start up the "server":

```lisp
> (start)
```
```lisp
true
```

Now you can do the following

```lisp
> (! (whereis 'our-proc) 'hi)
hi
> (! (whereis 'our-proc) 'hi)
hi
> (! (whereis 'our-proc) 'amount?)
amount?
Current state: 2
> (! (whereis 'our-proc) 'hi)
hi
> (! (whereis 'our-proc) 'amount?)
amount?
Current state: 3
```

Whadayaknow? This is looking like it might be the answer! No ugly state data displayed after each command, no weird function representation printed to our REPL -- this is a pretty clean user experience. We still get the output of our "send" command, but that's pretty easy to overlook. And we might be able to make that even better...

