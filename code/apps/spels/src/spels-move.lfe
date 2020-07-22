(defmodule spels-move
  (export all))

(include-lib "spels/include/records.lfe")

(defun get-valid-moves (exits)
  (lists:map
    (lambda (x)
      (list_to_atom (exit-direction x)))
    exits))

(defun match-directions
  ((player-dir (match-exit direction dir))
    (if (== dir (atom_to_list player-dir))
        'true
        'false)))

(defun get-new-location (player-dir exits)
  (exit-destination
    (car
      (lists:filter
        (lambda (exit) (match-directions player-dir exit))
        exits))))

(defun walk-direction (direction game-state)
  (let ((exits (place-exits (spels-env:get-here game-state))))
    (case (lists:member direction (get-valid-moves exits))
          ('true (spels-io:good-move
                   (set-state-player-location
                     game-state
                     (get-new-location direction exits))))
          ('false (spels-io:bad-move game-state)))))

(defun weld-ready? (game-state)
  (andalso (spels-inv:inv? 'bucket game-state)
           (spels-inv:inv? 'chain game-state)
           (== (state-player-location game-state) 'attic)))

(defun weld-them
  (('chain 'bucket game-state)
    (let ((ready? (spels-io:weld-ready? game-state)))
      (cond ((spels-goals:goal-met? 'weld-chain game-state)
              (spels-io:already-welded)
              game-state)
            ((not ready?)
              (spels-io:weld-not-ready)
              game-state)
            (ready?
              (spels-io:good-weld
                (spels-goals:update-goals 'weld-chain game-state))))))
  ((_ _ game-state)
    (spels-io:cant-weld)
    game-state))

(defun dunk-ready? (game-state)
  (andalso (spels-inv:inv? 'bucket game-state)
           (spels-goals:goal-met? 'weld-chain game-state)
           (== (state-player-location game-state) 'garden)))

(defun splash-ready? (game-state)
  (andalso (spels-inv:inv? 'bucket game-state)
           (spels-goals:goal-met? 'dunk-bucket game-state)
           (== (state-player-location game-state) 'living-room)))

(defmacro game-action (cmd sub obj goal-name)
  `(defun ,(spels-util:ccatoms `(do- ,cmd))
    ((',sub ',obj game-state)
      (let ((ready? (,(spels-util:ccatoms `(,cmd -ready?)) game-state)))
        (cond ((spels-goals:goal-met? ',goal-name game-state)
                (,(spels-util:ccatoms `(spels-io:already- ,cmd ed)))
                game-state)
              ((not ready?)
                (,(spels-util:ccatoms `(spels-io:,cmd -not-ready)))
                game-state)
              (ready?
                (,(spels-util:ccatoms `(spels-io:good- ,cmd))
                  (spels-goals:update-goals ',goal-name game-state))))))
    ((_ _ game-state)
      (,(spels-util:ccatoms `(spels-io:cant- ,cmd)))
      game-state)))

;; generates do-weld
(game-action weld chain bucket weld-chain)

;; generates do-dunk
(game-action dunk bucket well dunk-bucket)

;; generates do-splash
(game-action splash wizard bucket splash-wizard)
