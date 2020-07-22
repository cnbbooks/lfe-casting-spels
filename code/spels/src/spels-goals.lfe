(defmodule spels-goals
  (export all))

(include-lib "include/records.lfe")

(defun goal-matches?
  ((goal-name (= (match-goal name name) goal)) (when (== goal-name name))
    `#(true ,goal))
  ((_ _)
    'false))

(defun filter-goals (goal-name game-state)
  (lists:filtermap
    (lambda (x) (goal-matches? goal-name x))
    (state-goals game-state)))

(defun extract-goal
  (('())
    'undefined)
  ((`(,goal))
    goal))

(defun get-goal (goal-name game-state)
  (extract-goal (filter-goals goal-name game-state)))

(defun goal-met? (goal-name game-state)
  (let ((goal (get-goal goal-name game-state)))
    (if (== goal 'undefined)
        goal
        (goal-achieved? goal))))

(defun good-goal (item-name)
  (io:format "~nYou have achieved the '~s' goal!~n"
             (list (atom_to_list item-name))))

(defun check-goal
  ((goal-name (= (match-goal name g-name) goal)) (when (== goal-name g-name))
    (good-goal goal-name)
    (set-goal-achieved? goal 'true))
  ((_ goal) goal))

(defun update-goals (goal-name game-state)
  (set-state-goals
    game-state
    (lists:map
      (lambda (goal) (check-goal goal-name goal))
      (state-goals game-state))))
