# Organizing Things with Records

As we've said, our game is going to need the following:

* objects
* places
* place data (description, exits)
* object locations
* player location

We need to create a data structure to hold all of that, so that it can be passed to functions which need one or more bits of that data. As we mentioned when we talked about Non-Global State, The data structure we're going to use is the LFE *record*. A *record* is a simple data structure that lets us associate keys and values.

Let's attack this problem in pieces; we can start with the big picture, and then fill that in.
