(defrecord state
  objects
  places
  player-location
  goals)

(defrecord object
  name
  location)

(defrecord place
  name
  description
  exits)

(defrecord exit
  direction
  object
  destination)

(defrecord goal
  name
  achieved?)

(defun loaded-game-records ()
  "This is just a dummy function for display purposes when including from the
  REPL (the last function loaded has its name printed in stdout).

  This function needs to be the last one in this include."
  'ok)
