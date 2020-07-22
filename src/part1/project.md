# Project Space

We're going to use `rebar3` to automatically generate all the files we need
to start working on our game world :-) To do this, you will either need to
edit your global `rebar.config` file or create a local one, and make sure
the `rebar3_lfe` plugin is added.

If you'd like to have the `lfe` commands available on your system, then create
or edit your `~/.config/rebar3/rebar.config` to this:

```erlang
{plugins, [
  {rebar3_lfe, {git, "https://github.com/lfe-rebar3/rebar3_lfe.git", {branch, "master"}}}
]}.
```

If you already have plugins in that file, then just add another entry inside
`plugins, [...]`. 

If instead you just want to have the LFE `rebar3` plugin available locally,
then in your current working directly, create a `rebar.config` file and ensure
it has the above as its contents.

With this in place, we're ready to create the structure for our project:

```bash
rebar3 new lfe-escript casting-spels
```

Let's make sure everything's working as expected:

```bash
cd casting-spels
rebar3 lfe compile
rebar3 escriptize
rebar3 lfe run-escript
```

This generates `_build/default/bin/casting-spels`, a stand-alone script that
has everything we need packaged into it (that's what the `esctipize` command
above does). 

You can either run it directly (that file is executable) or you can use the
convenience command provided by the LFE `rebar3` plugin:

```bash
rebar3 lfe run-script
```

Right now, that just runs the auto-generated sample script which outputs the
following:

```shell
Got args: ()
Answer: 42
```

We will be changing that! But later; initially, we're going to spend most of 
our time in the LFE REPL ...
