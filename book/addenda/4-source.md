## Source Code

### Obtaining a Copy

The source code for the book is available at [https://github.com/lfe/casting-spels](https://github.com/lfe/casting-spels). To get a copy of this code, simply run:

```bash
$ git clone https://github.com/lfe/casting-spels.git
$ cd casting-spels
```


### Regular Version

In this repository, the file ``code/game.lfe`` contains all the code one enters in the REPL as following along in the book.

If you choose, you may load all of this code into the REPL as if you had typed it yourself:

```bash
$ make repl
```
```
Erlang/OTP 17 [erts-6.2] [source] [64-bit] [smp:4:4] [async-threads:10] [kernel-poll:false]

   ..-~.~_~---..
  (      \\     )    |   A Lisp-2+ on the Erlang VM
  |`-.._/_\\_.-';    |   Type (help) for usage info.
  |         g (_ \   |   
  |        n    | |  |   Docs: http://docs.lfe.io/ 
  (       a    / /   |   Source: http://github.com/rvirding/lfe
   \     l    (_/    |   
    \   r     /      |   LFE v1.0 (abort with ^G)
     `-E___.-'

>
```

```lisp
> (run "game.lfe")
game-data-loaded
```

And now you will be able to execute the commands that would be available at the end of the book.

### OTP Version

As mentioned in the previous section, source code for an OTP version of the game has been made available in ``code/spels``. To start the REPL for this version, simply run ``make otp-repl``. Note that this code is *very* different from the code that is entered into the REPL throughout the course of the book, and some commands will not be present (or will have been changed).

For more details, please see the previous section.
