# Project Space

Most of this book takes place in the REPL, and as such, we're not going to be writing to files like you see in many non-Lisp tutorials. At the end of the book, you'll have the option of loading all the code created for this book. Also, there's a chapter at the end that briefly covers running production-ready code (using OTP project releases). For those two chapters, you'll be using `rebar3`.

However, you may want to set up a project for the book now, so you can follow along with the code in the repository. You can do that by cloning and switching to the code directory:

```bash
git clone https://github.com/lfe/casting-spels.git
cd casting-spels/code
```

Next you'll want to creat a release (we'll talk about this a bit more later; the code in the `casting-spels` repository has been set up as an LFE/OTP release, mostly to engender good habits in the hearts and minds of LFE newcomers :-)).

```bash
rebar3 release
```

That will download some plugins and some dependencies (including LFE itself!), compile them, and make all the project code accessible in a release directory. Again, a little more on that later.
