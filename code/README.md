# Casting SPELs with LFE

*The OTP Version*

## Preparation

You can build the release, start the game server, an hop into the LFE REPL with just one command:

```bash
$ make play
```

```lisp
Erlang/OTP 17 [erts-6.2] [source] [64-bit] [smp:4:4] [async-threads:10]

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

## Two Ways to Play

You have two options for playing the game:
* [In LFE itself](docs/lfe-syntax-walkthrough.md), calling LFE functions (or macros)
* [Using the custom game REPL](docs/zork-syntax-walkthrough.md) which has its own simple DSL (Zork-inspired)
