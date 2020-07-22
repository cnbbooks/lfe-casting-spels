(defmodule spels-inv
  (export all))

(include-lib "include/records.lfe")

(defun check-item
  ((item-name (= (match-object name obj-name) obj)) (when (== item-name obj-name))
    (spels-io:good-pick item-name)
    (set-object-location obj 'player))
  ((_ obj) obj))

(defun update-items (item-name game-state)
  (lists:map
    (lambda (obj) (check-item item-name obj))
    (state-objects game-state)))

(defun get-item-names (game-state)
  (lists:map
    (lambda (x) (object-name x))
    (spels-env:whats-here? game-state)))

(defun pickup-item
  ((item-name (= (match-state player-location player-loc objects objs) game-state))
    (case (lists:member item-name (get-item-names game-state))
          ('true
            (set-state-objects
              game-state (update-items item-name game-state)))
          ('false
            (spels-io:bad-pick)
            game-state))))

(defun inv-obj
  (((match-state objects objs))
    (lists:filter
      (match-lambda
        (((match-object location 'player)) 'true)
        ((_) 'false))
      objs)))

(defun inv-name (game-state)
  (lists:map
    (lambda (x) (object-name x))
    (inv-obj game-state)))

(defun inv? (item-name game-state)
  (lists:member item-name (inv-name game-state)))

