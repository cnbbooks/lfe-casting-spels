(defmacro go (direction)
  `(spels-game:go ',direction))

(defun look ()
  (spels-game:look))

(defun exits ()
  (spels-game:exits))

(defun inv ()
  (spels-game:inv))

(defmacro take (item)
  `(spels-game:take ',item))

(defmacro weld (subj obj)
  `(spels-game:weld ',subj ',obj))

(defmacro dunk (subj obj)
  `(spels-game:dunk ',subj ',obj))

(defmacro splash (subj obj)
  `(spels-game:splash ',subj ',obj))

(defun loaded-game-commands ()
  "This is just a dummy function for display purposes when including from the
  REPL (the last function loaded has its name printed in stdout).

  This function needs to be the last one in this include."
  'ok)
