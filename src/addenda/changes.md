## Changes from the Original

As mentioned in the introduction to the LFE edition of "Casting SPELs in Lisp" the changes from the original (written in Common Lisp) are many. Primarily this was due to the fact that LFE (and Erlang) does not support mutable data nor global state (two very good things to avoid). As such, the game had to be restrcutured to pass state data (in the form of LFE records) and, eventually, a process server to manage state in a safe, non-global manner.

These resulted in a great deal more work required of the coder, since the game is no longer as simple an application as that developed in the original. However, it does to a good job of preparing the reader (coder!) for writing applications in LFE using OTP (highly recommended), and as such offers a great jumping-off point for real-world LFE.

All this being said, every attempt was made to preserve the fun and tone of the original -- if we have not done that, then we have failed.
