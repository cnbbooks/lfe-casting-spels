## Record Functions

Wait -- before we make game commands, let's take a quick time-out for a piblic service announcement: records are your friends! And they come with magically created functions. You'll be seeing more of them, so let's get you introduced.

As noted, for every record we define, a bunch of functions are magically created by LFE. These functions let us:
 * create records of the given type
 * retreive values from the record
 * update values in a record
 * extract metadata from a record

The record functions which you will be seeing more of shortly are those of the following forms:
* ``make-<name>`` - create a new record
* ``<name>-<field>`` - get a record field value
* ``set-<name>`` - set a whole record
* ``set-<name>-<field>`` - set the value of a record field
* ``match-<name>`` - use a record while *pattern matching*

This is not a complete list, but it's enough get get us started! (see the
[Reference Guide](http://lfe.gitbooks.io/reference-guide/content/16.html) for
more details).

*Now* we can create some game commands ...
