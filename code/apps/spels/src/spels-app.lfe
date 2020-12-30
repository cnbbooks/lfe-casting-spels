(defmodule spels-app
  (behaviour application)
  (export
    ;; app implementation
    (start 2)
    (stop 0)))

;;; --------------------------
;;; application implementation
;;; --------------------------

(defun start (_type _args)
  (logger:set_application_level 'spels 'all)
  (logger:info "Starting spels application ...")
  (spels-sup:start_link))

(defun stop ()
  (spels-sup:stop)
  'ok)
