# Objects

Let's create some objects, a list of *atoms*:

```lisp
lfe> (set objects '(whiskey-bottle bucket frog chain))
```
```lisp
(whiskey-bottle bucket frog chain)
```

Ok, now let's dissect this line and see what it means: 

Since a Lisp compiler always starts reading things in *Code Mode* and expects a form, the first symbol, ``set``, must be a command. In this case, the command sets a variable to a value: The variable is ``objects`` The value we are setting it to is a list of the four objects in our game. Now, since the list is data (i.e. we don't want the compiler to try and call a function with the name of ``whiskey-bottle``) we need to "flip" the compiler into *Data Mode* when reading the list. The single quote in front of the list is the command that tells the compiler to flip:

![](../images/objects.jpg)
