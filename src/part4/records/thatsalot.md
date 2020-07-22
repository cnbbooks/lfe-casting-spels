# That's a LOT!

Yeah, it might seem that way for a simple little game :-) But! Taking an approach like this (where the core data of a systems is very well-defined) means that things will be much cleaner and less susceptible to bugs. Each item of data is explicit, with functions that create the data, access the data, and update the data -- both the "magical" record functions mentioned above as well as functions defined in the Erlang standard library (e.g., the ``proplists`` and ``orddict`` modules).

Furthermore, this is a common practice used in many real-world Erlang and LFE applications: records are passed as inputs to functions and returned as (often updated) outputs, which in turn are fed into other functions.
