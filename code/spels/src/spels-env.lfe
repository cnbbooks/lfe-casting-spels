(defmodule spels-env
  (export all))

(include-lib "include/records.lfe")

(defun here?
  ((loc (match-state places places))
    (here? loc places))
  ((loc (match-place name place-name)) (when (== loc place-name))
    'true)
  ((_ _)
    'false))

(defun get-here
  (((match-state player-location player-loc places locs))
    (car (lists:filter
           (lambda (loc)
             (here? player-loc loc))
           locs))))

(defun item-there?
  ((loc (match-object location obj-loc)) (when (== loc obj-loc))
      'true)
  ((_ _)
      'false))

(defun whats-here?
  (((match-state player-location player-loc objects objs))
    (lists:filter
      (lambda (obj)
        (item-there? player-loc obj))
      objs)))
