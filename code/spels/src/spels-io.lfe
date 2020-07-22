(defmodule spels-io
  (export all))

(include-lib "include/records.lfe")

(defun describe-location (game-state)
  (++ (place-description (spels-env:get-here game-state)) "\n"))

(defun describe-exit
  (((match-exit object obj direction dir))
    (++ "There is a " obj " going " dir " from here.")))

(defun describe-exits (game-state)
  (clj:->> game-state
           (spels-env:get-here)
           (place-exits)
           (lists:map #'describe-exit/1)
           (spels-util:join)))

(defun display-exits (game-state)
  (clj:->> game-state
           (describe-exits)
           (spels-util:wrap-text)
           (list)
           (io:format "~n~s")))

(defun describe-item
  (((match-object name obj-name))
    (++ "You see a " (atom_to_list obj-name) " on the ground.")))

(defun describe-items (game-state)
  (clj:->> game-state
           (spels-env:whats-here?)
           (lists:map #'describe-item/1)
           (spels-util:join)
           (spels-util:add-newline)))

(defun display-scene (game-state)
  (clj:->> game-state
           (funcall (lambda (x)
             (list (describe-location x)
                   (describe-items x)
                   (describe-exits x))))
           (lists:map #'spels-util:wrap-text/1)
           (io:format "~n~s~s~s")))

(defun good-move (game-state)
  (display-scene game-state)
  game-state)

(defun bad-move (game-state)
  (io:format "~nYou can't go that way.~n")
  game-state)

(defun good-pick (item-name)
  (io:format "~nYou are now carrying the ~s.~n"
             (list (atom_to_list item-name))))

(defun bad-pick ()
  (io:format "~nThat item is not here.~n"))

(defun get-inv-str (game-state)
  (string:join
    (lists:map
      (lambda (x) (++ " - " (atom_to_list x) "\n"))
      (spels-inv:inv-name game-state))
    ""))

(defun display-inv (game-state)
  (let ((inv-str (get-inv-str game-state)))
    (case inv-str
      ('() (io:format "~nYou are not carrying anything.~n"))
      (_ (io:format "~nYou are carrying the following:~n~s"
                    (list inv-str))))))

(defun weld-not-ready ()
  (io:format "~nYou seem to be missing a key condition for welding ...~n"))

(defun cant-weld ()
  (io:format "~nYou can't weld like that ...~n"))

(defun good-weld (game-state)
  (io:format "~nThe chain is now securely welded to the bucket.~n")
  game-state)

(defun already-welded ()
  (io:format "~nYou have already welded the bucket and chain!~n"))

(defun dunk-not-ready ()
  (io:format "~nYou seem to be missing a key condition for dunking ...~n"))

(defun cant-dunk ()
  (io:format "~nYou can't dunk like that ...~n"))

(defun good-dunk (game-state)
  (io:format "~nThe bucket is now full of water.~n")
  game-state)

(defun already-dunked ()
  (io:format "~nYou filled the bucket. Again.~n"))

(defun splash-not-ready ()
  (io:format "~nYou seem to be missing a key condition for splashing ...~n"))

(defun cant-splash ()
  (io:format "~nYou can't splash like that ...~n"))

(defun won-msg ()
  (io:format (++ "~nThe wizard awakens from his slumber, greets you "
                 "warmly, and thanks you for~npulling him out of a rather "
                 "nasty dream.~nYour reward, it seems, is a magical "
                 "low-carb donut which he hands you ...~nright before "
                 "drifting off to sleep again.~n~nYou won!!~n")))

(defun lost-msg ()
  (io:format (++ "~nThe wizard awakens to see that you are in possession "
                 "of his most precious --~nand dangerous! -- frog.~nHe "
                 "completely looses it.~nAs he waves his wand at you, "
                 "everything disappears ...~n")))

(defun good-splash (game-state)
  (case (spels-inv:inv? 'frog game-state)
    ('false
      (won-msg)
      game-state)
    ('true
      (lost-msg)
      (set-state-player-location game-state 'netherworld))))

(defun already-splashed ()
  (io:format (++ "~nYou've already woken the wizard once. With a bucket full "
                 "of well water.~n"
                 "Best not push your luck.~n")))

(defun spell-of-mercy ()
  (timer:sleep 2000)
  (io:format (++ "~nFrom deep in the mists, you hear a familiar intonation ...~n"
                 "Great relief washes over you, as you recognize the "
                 "time-travel spell -- you're~nnot doomed!~n~n"))
  (timer:sleep 4000)
  (io:format (++ "Confident that you will never pick up the frog again, "
                 "things get a bit fuzzy.~nYou start to lose consciousness"
                 "as the wizard pulls you back in time. Your~nlast thought is "
                 "that you're probably not going to remember any of this "
                 "...~n~n"))
  (timer:sleep 4000)
  (let ((state (spels-world:init-state)))
    (display-scene state)
    state))

(defun hope-for-mercy (state)
  (if (> 0.25 (random:uniform))
        (spell-of-mercy)
        state))

(defun divider ()
  '(list_to_atom (string:copies "-" 78)))
