(defmodule spels-util
  (export all))

(defun add-newline
  (('()) '())
  ((string) (++ string "\n")))

(defun make-regex-str (max-len)
  (++ "(.{1," (integer_to_list max-len) "}|\\S{"
      (integer_to_list (+ max-len 1)) ",})(?:\\s[^\\S\\r\\n]*|\\Z)"))

(defun wrap-text (text max-len)
  (let ((find-patt (make-regex-str max-len))
        (replace-patt "\\1\\\n"))
    (re:replace text find-patt replace-patt
                '(global #(return list)))))

(defun wrap-text (text)
  (wrap-text text 78))

(defun join (strings)
  (string:join strings " "))

(defun add-next-atom (next-atom so-far)
  (++ so-far
      (atom_to_list next-atom)))

(defun ccatoms (atoms)
  (list_to_atom
    (lists:foldl #'add-next-atom/2 "" atoms)))
