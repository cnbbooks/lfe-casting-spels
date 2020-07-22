## The Functional Programming Style

We've mentioned it once or twice, so it's probably time to talk about it in some more detail: *functional programming* (to be clear, this is completely unrelated in any way to the concept called "procedural programming" or "structural programming" that you might have learned about in school). In this style, the goal is to write functions that always follow the following rules:

* You only read variables that are passed into the function or are created by the function (So you don't read any global variables)

* You never change the value of a variable that has already been set (So no incrementing variables or other such risky behaviour!)

For *pure* functional programming, there is another rule:

* You never interact with the outside world, besides returning a result value. (So no writing to files, no writing messages for the user)

You may be wondering if you can actually write any code like this that actually does anything useful, given these brutal restrictions... the answer is yes, once you get used to the style... 

But why would anyone bother following these rules? 

One very important reason: Writing code in this style gives your program *referential transparency*: This means that a given piece of code, called with the same parameters, always positively returns the same result and does exactly the same thing no matter when you call it. This can reduce programming errors and is believed to improve programmer productivity in many cases.

Of course, you'll always have some functions that are not *purely functional* in style or you couldn't communicate with the user or other parts of the outside world. As such, we're going to be focusing on the first two rules in this book.
