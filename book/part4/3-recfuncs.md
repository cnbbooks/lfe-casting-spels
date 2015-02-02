## Record Functions

As noted, for every record we define, a bunch of functions are magically created by Lisp. These functions let us:
 * create records of the given type
 * retreive values from the record
 * update values in a record
 * extract metadata from a record

The record functions which you will be seeing more of shortly are those of the following forms:
* ``make-<name>`` - create a new record
* ``<name>-<field>`` - get a record field value
* ``set-<name>`` - sset a whole record
* ``set-<name>-<field>`` - set the value of a record field

This is not a complete list, but it's enough for now!
