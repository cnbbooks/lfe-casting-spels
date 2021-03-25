(defmodule spels
  (export
   (help 0)
   (start 0)))

(defun read ()
  (string:trim (io:get_line "spels> ")))

(defun eval (input)
  (case (re:split input "\s+" '(#(return list)))
    (`("help") (help))
    (`("go" ,dir) (go dir))
    (`("n") (go "north"))
    (`("north") (go "north"))
    (`("e") (go "east"))
    (`("east") (go "east"))
    (`("s") (go "south"))
    (`("south") (go "south"))
    (`("w") (go "west"))
    (`("west") (go "west"))
    (`("u") (go "upstairs"))
    (`("upstairs") (go "upstairs"))
    (`("d") (go "downstairs"))
    (`("downstairs") (go "downstairs"))
    (`("move" ,dir) (go dir))
    (`("travel" ,dir) (go dir))
    (`("look") (spels-game:look))
    (`("desc") (spels-game:look))
    (`("describe") (spels-game:look))
    (`("exits") (spels-game:exits))
    (`("get" ,item) (take item))
    (`("take" ,item) (take item))
    (`("pickup" ,item) (take item))
    (`("weld" ,subj ,obj) (weld subj obj))
    (`("dunk" ,subj ,obj) (dunk subj obj))
    (`("splash" ,subj ,obj) (splash subj obj))
    (`("quit") #(loop-command quit))
    (`("shutdown") #(loop-command shutdown))
    (_ (io:format "~n~s~n" `(,(command-unknown))))))

(defun print (result)
  (timer:sleep 100)
  (io:format "\n")
  result)

(defun loop
  ((#(loop-command quit))
   (io:format "Good-bye.~n"))
  ((#(loop-command shutdown))
   (progn
     (io:format "Shutting down ...~n~n")
     (io:format "Good-bye.~n~n")
     (erlang:halt 0)))
  ((_)
   (loop (print (eval (read))))))

(defun start ()
  (io:format
    (++
      "~n"
      "         ..~~;;;##################################;;;~~..~n"
      " .....~~.~~~~~~~~;;;###    Casting SPELs in LFE    ###;;;~~~~~~~~.~~.....~n"
      "       ..~~.~~;;;##################################;;;~~.~~..~n"
      "~n"
      "Welcome!~n"
      "~n"
      "Type 'help' (without the quotes) for a list of available commands.~n"
      "To jump right in and play, you can start with the 'look' command :-)~n~n"
      ))
  (loop 'run-custom-repl))

(defun help ()
  (io:format
    (++
      "~nYou are not in a maze, there are no twisty passages, and everything~n"
      "is pretty much not the same.~n~n"
      "You are not, however, witout aid. Here are the available commands:~n"
      "~n"
      "  dunk SUB OBJ   - Dunk one item in another.~n"
      "  go DIR         - Move in a particular direction. For valid values of~n"
      "                   DIR, use the 'exits' command. Note that for movement~n"
      "                   the first letter of the direction may be used as the~n"
      "                   command itself, e.g., 'n' for 'north'.~n"
      "  exits          - List the exits availble to the player from the~n"
      "                   current location.~n"
      "  help           - Display this help text.~n"
      "  inv            - List the items currently in the player's~n"
      "                   possession.~n"
      "  look           - Examine the surroundings.~n"
      "                   Command aliases: describe, desc~n"
      "  quit           - Quit the game and return to the LFE REPL.~n"
      "  shutdown       - Quit and stop the game, returning to the system~N"
      "                   shell~n"
      "  splash SUB OBJ - Splash something with another thing.~n"
      "  take ITEM      - Take possession of the given item. Valid values~n"
      "                   for ITEM are the items described when (look)ing.~n"
      "                   Command aliases: get, pickup~n"
      "  weld SUB OBJ   - Weld two things together.~n~n")))

(defun go (dir)
  (spels-game:go (erlang:list_to_atom dir)))

(defun take (item)
  (spels-game:take (erlang:list_to_atom item)))

(defun weld (subj obj)
  (spels-game:weld
    (erlang:list_to_atom subj)
    (erlang:list_to_atom obj)))

(defun dunk (subj obj)
  (spels-game:dunk
    (erlang:list_to_atom subj)
    (erlang:list_to_atom obj)))

(defun splash (subj obj)
  (spels-game:splash
    (erlang:list_to_atom subj)
    (erlang:list_to_atom obj)))

(defun command-unknown ()
  (let ((resposes '("I don't know how to do that."
                    "Say what?"
                    "Come again?"
                    "I didn't understand you."
                    "You want me to do WHAT?!?!"
                    "Are you drunk-gaming?"
                    "You need to work on those typing skills.")))
    (lists:nth (rand:uniform (length resposes)) resposes)))
