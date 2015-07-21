## Non-Global State

What are the alternatives to global state? One of the most common techniques in functional programming languages like LFE, is to pass data from one function to the other. If a function needs to change data, then it outputs a new copy of the data with the change, and this changed data is then passed to other functions.

In LFE, a common *pattern* (something you *do* want to do) is to create a "state" data structure, and pass this around. You can use *property lists* for this, but *records* are more common. The most recent versions of Erlang allow the use of *maps*.

The game you're going to create in LFE will use *records*. As we start writing our functions, accessing our data, and changing the game state, watch closely: you're going to be learning some of the classic techniques of *functional programming*.

Hints to keep in mind:

* You will need a data structure that captures the complete state of the game (objects, locations, players, etc., and all the ways in which these might change).
* Any time you wish to perform a calcualtion based upon game state, you will need to pass the state into your function as an argument.
* Any time you wish to update game data, you will need to output the modified state, and then use that new state in the rest of your code.
