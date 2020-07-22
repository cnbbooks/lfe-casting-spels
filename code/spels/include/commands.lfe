(defmacro go (direction)
  `(spels-game:go ',direction))

(defmacro move (direction)
  `(spels-game:go ',direction))

(defun look ()
  (spels-game:look))

(defun desc ()
  (spels-game:look))

(defun describe ()
  (spels-game:look))

(defun exits ()
  (spels-game:exits))

(defun inv ()
  (spels-game:inv))

(defmacro get (item)
  `(spels-game:take ',item))

(defmacro take (item)
  `(spels-game:take ',item))

(defmacro pickup (item)
  `(spels-game:take ',item))

(defmacro weld (subj obj)
  `(spels-game:weld ',subj ',obj))

(defmacro dunk (subj obj)
  `(spels-game:dunk ',subj ',obj))

(defmacro splash (subj obj)
  `(spels-game:splash ',subj ',obj))

(defun start ()
  (spels-game:start))

(defun stop ()
  (spels-game:stop))

(defun quit ()
  (erlang:halt 0))

(defun help ()
  (io:format 
    (++
      "~nYou are not in a maze, there are no twisty passages, and everything~n"
      "is pretty much not the same.~n~n"
      "You are not, however, witout aid. Here are the available commands:~n"
      "~n"
      "  (dunk SUB OBJ)   - Dunk one item in another.~n"
      "  (go DIR)         - Move in a particular direction. Valid values for~n"
      "                     DIR: east, west, north, south.~n"
      "                     Command alias: move~n"

      "  (exits)          - List the exits availble to the player from the~n"
      "                     current location.~n"
      "  (help)           - Display this help text.~n"
      "  (inv)            - List the items currently in the player's~n"
      "                     possession.~n"
      "  (look)           - Examine the surroundings.~n"
      "                     Command aliases: describe, desc~n"
      "  (quit)           - Quit the game.~n"
      "  (splash SUB OBJ) - Splash something with another thing.~n"
      "  (start)          - Start the game server.~n"
      "  (stop)           - Stop the game server.~n"
      "  (take ITEM)      - Take possession of the given item. Valid values~n"
      "                     for ITEM are the items described when (look)ing.~n"
      "                     Command aliases: get, pickup~n"
      "  (weld SUB OBJ)   - Weld two things together.~n~n")))

(defun loaded-game-commands ()
  "This is just a dummy function for display purposes when including from the
  REPL (the last function loaded has its name printed in stdout).

  This function needs to be the last one in this include."
  'ok)
