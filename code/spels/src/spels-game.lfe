(defmodule spels-game
  (behaviour gen_server)
  (export
    ;; gen_server implementation
    (start 0)
    (stop 0)
    ;; callback implementation
    (init 1)
    (handle_call 3)
    (handle_cast 2)
    (handle_info 2)
    (terminate 2)
    (code_change 3)
    ;; server API
    (go 1)
    (look 0)
    (exits 0)
    (inv 0)
    (take 1)
    (weld 2)
    (dunk 2)
    (splash 2)))

(include-lib "spels/include/records.lfe")

;;; config functions

(defun server-name () (MODULE))
(defun callback-module () (MODULE))
(defun genserver-opts () '())
(defun register-name () `#(local ,(server-name)))
(defun unknown-command () #(error "Unknown command."))

;;; gen_server implementation

(defun start ()
  (gen_server:start (register-name)
                    (callback-module)
                    (spels-world:init-state)
                    (genserver-opts)))

(defun stop ()
  (gen_server:call (server-name) 'stop))

;;; callback implementation

(defun init (initial-state)
  `#(ok ,initial-state))

(defun handle_cast
  (('look state)
    (spels-io:display-scene state)
    (case (state-player state)
      ('netherworld
        `#(noreply ,(spels-io:hope-for-mercy state)))
      (_
        `#(noreply ,state))))
  (('exits state)
    (spels-io:display-exits state)
    `#(noreply ,state))
  (('inv state)
    (spels-io:display-inv state)
    `#(noreply ,state))
  ((`#(go ,direction) state)
    `#(noreply ,(spels-move:walk-direction direction state)))
  ((`#(take ,item) state)
    `#(noreply ,(spels-inv:pickup-item item state)))
  ((`#(weld ,subj ,obj) state)
    `#(noreply ,(spels-move:do-weld subj obj state)))
  ((`#(dunk ,subj ,obj) state)
    `#(noreply ,(spels-move:do-dunk subj obj state)))
  ((`#(splash ,subj ,obj) state)
    `#(noreply ,(spels-move:do-splash subj obj state)))
  ((message state)
    `#(noreply ,state)))

(defun handle_call
  (('stop _caller state)
    `#(stop shutdown ok state))
  ((message _caller state)
    `#(reply ,(unknown-command) ,state)))

(defun handle_info
  ((`#(EXIT ,_pid normal) state)
   `#(noreply ,state))
  ((`#(EXIT ,pid ,reason) state)
   (io:format "Process ~p exited! (Reason: ~p)~n" `(,pid ,reason))
   `#(noreply ,state))
  ((_msg state)
   `#(noreply ,state)))

(defun terminate (_reason _state)
  'ok)

(defun code_change (_old-version state _extra)
  `#(ok ,state))

(defun send (cmd)
  (gen_server:cast (server-name) cmd))

(defun send (cmd arg)
  (gen_server:cast (server-name) `#(,cmd ,arg)))

(defun send (cmd arg1 arg2)
  (gen_server:cast (server-name) `#(,cmd ,arg1 ,arg2)))

;;; our server API

(defun look ()
  (send 'look))

(defun inv ()
  (send 'inv))

(defun exits ()
  (send 'exits))

(defun go (direction)
  (send 'go direction))

(defun take (item)
  (send 'take item))

(defun weld (subj obj)
  (send 'weld subj obj))

(defun dunk (subj obj)
  (send 'dunk subj obj))

(defun splash (subj obj)
  (send 'splash subj obj))
