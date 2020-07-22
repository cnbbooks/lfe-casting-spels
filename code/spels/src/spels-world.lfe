(defmodule spels-world
  (export all))

(include-lib "include/records.lfe")

(defun objects ()
  `(,(make-object name 'whiskey-bottle location 'living-room)
    ,(make-object name 'bucket location 'living-room)
    ,(make-object name 'frog location 'garden)
    ,(make-object name 'chain location 'garden)))

(defun living-room ()
  (make-place
    name 'living-room
    description (++ "You are in the living-room of a wizard's house. "
                    "There is a wizard snoring loudly on the couch.")
    exits `(,(make-exit
               direction "west"
               object "door"
               destination 'garden)
            ,(make-exit
               direction "upstairs"
               object "stairway"
               destination 'attic))))

(defun garden ()
  (make-place
    name 'garden
    description (++ "You are in a beautiful garden. "
                    "There is a well in front of you.")
    exits `(,(make-exit
               direction "east"
               object "door"
               destination 'living-room))))

(defun attic ()
  (make-place
    name 'attic
    description (++ "You are in the attic of the wizard's house. "
                    "There is a giant welding torch in the corner.")
    exits `(,(make-exit
               direction "downstairs"
               object "stairway"
               destination 'living-room))))

(defun netherworld ()
  (make-place
    name 'netherworld
    description (++ "Everything is misty and vague. "
                    "You seem to be in the netherworld.\n"
                    "There are no exits.\n"
                    "You could be here for a long, long time ...")
    exits '()))

(defun goals ()
  `(,(make-goal name 'weld-chain achieved? 'false)
    ,(make-goal name 'dunk-bucket achieved? 'false)
    ,(make-goal name 'splash-wizard achieved? 'false)))

(defun init-state ()
  (make-state
    objects (objects)
    places (list (living-room) (garden) (attic) (netherworld))
    player-location 'living-room
    goals (goals)))
