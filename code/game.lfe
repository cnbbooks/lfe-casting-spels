(reset-environment)

(defrecord state
  objects
  places
  player-location
  goals)

(defrecord object
  name
  location)

(set objects
  (list (make-object name 'whiskey-bottle location 'living-room)
        (make-object name 'bucket location 'living-room)
        (make-object name 'frog location 'garden)
        (make-object name 'chain location 'garden)))

(defrecord place
  name
  description
  exits)

(defrecord exit
  direction
  object
  destination)

(set living-room
  (make-place
    name 'living-room
    description (++ "You are in the living-room of a wizard's house. "
                    "There is a wizard snoring loudly on the couch.")
    exits (list
            (make-exit
              direction "west"
              object "door"
              destination 'garden)
            (make-exit
              direction "upstairs"
              object "stairway"
              destination 'attic))))

(set garden
  (make-place
    name 'garden
    description (++ "You are in a beautiful garden. "
                    "There is a well in front of you.")
    exits (list
            (make-exit
              direction "east"
              object "door"
              destination 'living-room))))

(set attic
  (make-place
    name 'attic
    description (++ "You are in the attic of the wizard's house. "
                    "There is a giant welding torch in the corner.")
    exits (list
            (make-exit
              direction "downstairs"
              object "stairway"
              destination 'living-room))))

(set netherworld
  (make-place
    name 'netherworld
    description (++ "Everything is misty and vague. "
                    "You seem to be in the netherworld.\n"
                    "There are no exits.\n"
                    "You could be here for a long, long time ...")
    exits '()))

(defrecord goal
  name
  achieved?)

(set goals
  (list (make-goal name 'weld-chain achieved? 'false)
        (make-goal name 'dunk-bucket achieved? 'false)
        (make-goal name 'splash-wizard achieved? 'false)))

(set state (make-state
             objects objects
             places (list living-room garden attic netherworld)
             player-location 'living-room
             goals goals))

(defun here?
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

(defun describe-location (game-state)
  (++ (place-description (get-here game-state)) "\n"))

(defun describe-exit
  (((match-exit object obj direction dir))
    (++ "There is a " obj " going " dir " from here.")))

(defun describe-exits (game-state)
  (string:join
    (lists:map
      #'describe-exit/1
      (place-exits (get-here game-state)))
    " "))

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

(defun describe-item
  (((match-object name obj-name))
    (++ "You see a " (atom_to_list obj-name) " on the ground.")))

(defun add-newline
  (('()) '())
  ((string) (++ string "\n")))

(defun describe-items (game-state)
  (add-newline
    (string:join
      (lists:map
        #'describe-item/1
        (whats-here? game-state))
      " ")))

(defun display-scene (game-state)
  (io:format
    "~n~s~s~s"
    (list (describe-location game-state)
          (describe-items game-state)
          (describe-exits game-state))))

(defun display-exits (game-state)
  (io:format
    "~n~s"
    (list (describe-exits game-state))))

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

(defun good-move (game-state)
  (display-scene game-state)
  game-state)

(defun bad-move (game-state)
  (io:format "~nYou can't go that way.~n")
  game-state)

(defun walk-direction (direction game-state)
  (let ((exits (place-exits (get-here game-state))))
    (case (lists:member direction (get-valid-moves exits))
          ('true (good-move
                   (set-state-player-location
                     game-state
                     (get-new-location direction exits))))
          ('false (bad-move game-state)))))

(defmacro defspel body `(defmacro ,@body))

(defspel walk (direction game-state)
  `(walk-direction ',direction ,game-state))

(defun good-pick (item-name)
  (io:format "~nYou are now carrying the ~s.~n"
             (list (atom_to_list item-name))))

(defun check-item
  ((item-name (= (match-object name obj-name) obj)) (when (== item-name obj-name))
    (good-pick item-name)
    (set-object-location obj 'player))
  ((_ obj) obj))

(defun update-items (item-name game-state)
  (lists:map
    (lambda (obj) (check-item item-name obj))
    (state-objects game-state)))

(defun get-item-names (game-state)
  (lists:map
    (lambda (x) (object-name x))
    (whats-here? game-state)))

(defun bad-pick ()
  (io:format "~nThat item is not here.~n"))

(defun pickup-item
  ((item-name (= (match-state player-location player-loc objects objs) game-state))
    (case (lists:member item-name (get-item-names game-state))
          ('true
            (set-state-objects
              game-state (update-items item-name game-state)))
          ('false
            (bad-pick)
            game-state))))

(defspel pickup (item-name game-state)
  `(pickup-item ',item-name ,game-state))

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

(defun get-inv-str (game-state)
  (string:join
    (lists:map
      (lambda (x) (++ " - " (atom_to_list x) "\n"))
      (inv-name game-state))
    ""))

(defun display-inv (game-state)
  (let ((inv-str (get-inv-str game-state)))
    (case inv-str
      ('() (io:format "~nYou are not carrying anything.~n"))
      (_ (io:format "~nYou are carrying the following:~n~s"
                    (list inv-str))))))

(defun inv? (item-name game-state)
  (lists:member item-name (inv-name game-state)))

(defun goal-matches?
  ((goal-name (= (match-goal name name) goal)) (when (== goal-name name))
    `#(true ,goal))
  ((_ _)
    'false))

(defun filter-goals (goal-name game-state)
  (lists:filtermap
    (lambda (x) (goal-matches? goal-name x))
    (state-goals state)))

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

(defun weld-ready? (game-state)
  (andalso (inv? 'bucket game-state)
           (inv? 'chain game-state)
           (== (state-player-location game-state) 'attic)))

(defun weld-not-ready ()
  (io:format "~nYou seem to be missing a key condition for welding ...~n"))

(defun cant-weld ()
  (io:format "~nYou can't weld like that ...~n"))

(defun good-weld (game-state)
  (io:format "~nThe chain is now securely welded to the bucket.~n")
  game-state)

(defun already-welded ()
  (io:format "~nYou have already welded the bucket and chain!~n"))

(defun weld-them
  (('chain 'bucket game-state)
    (let ((ready? (weld-ready? game-state)))
      (cond ((goal-met? 'weld-chain game-state)
              (already-welded)
              game-state)
            ((not ready?)
              (weld-not-ready)
              game-state)
            (ready?
              (good-weld
                (update-goals 'weld-chain game-state))))))
  ((_ _ game-state)
    (cant-weld)
    game-state))

(defun dunk-ready? (game-state)
  (andalso (inv? 'bucket game-state)
           (goal-met? 'weld-chain game-state)
           (== (state-player-location game-state) 'garden)))

(defun dunk-not-ready ()
  (io:format "~nYou seem to be missing a key condition for dunking ...~n"))

(defun cant-dunk ()
  (io:format "~nYou can't dunk like that ...~n"))

(defun good-dunk (game-state)
  (io:format "~nThe bucket is now full of water.~n")
  game-state)

(defun already-dunked ()
  (io:format "~nYou filled the bucket. Again.~n"))

(defun dunk-it
  (('bucket 'well game-state)
    (let ((ready? (dunk-ready? game-state)))
      (cond ((goal-met? 'dunk-bucket game-state)
              (already-dunked)
              game-state)
            ((not ready?)
              (dunk-not-ready)
              game-state)
            (ready?
              (good-dunk
                (update-goals 'dunk-bucket game-state))))))
  ((_ _ game-state)
    (cant-dunk)
    game-state))

(defun add-next-atom (next-atom so-far)
  (++ so-far
      (atom_to_list next-atom)))

(defun ccatoms (atoms)
  (list_to_atom
    (lists:foldl #'add-next-atom/2 "" atoms)))

(defmacro game-action (cmd sub obj goal-name)
  `(defun ,(ccatoms `(do- ,cmd))
    ((',sub ',obj game-state)
      (let ((ready? (,(ccatoms `(,cmd -ready?)) game-state)))
        (cond ((goal-met? ',goal-name game-state)
                (,(ccatoms `(already- ,cmd ed)))
                game-state)
              ((not ready?)
                (,(ccatoms `(,cmd -not-ready)))
                game-state)
              (ready?
                (,(ccatoms `(good- ,cmd))
                  (update-goals ',goal-name game-state))))))
    ((_ _ game-state)
      (,(ccatoms `(cant- ,cmd)))
      game-state)))

(game-action weld chain bucket weld-chain)

(defspel weld-chain (game-state)
  `(do-weld 'chain 'bucket ,game-state))

(game-action dunk bucket well dunk-bucket)

(defspel dunk-bucket (game-state)
  `(do-dunk 'bucket 'well ,game-state))

(defun splash-ready? (game-state)
  (andalso (inv? 'bucket game-state)
           (goal-met? 'dunk-bucket game-state)
           (== (state-player-location game-state) 'living-room)))

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
  (case (inv? 'frog game-state)
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

(game-action splash wizard bucket splash-wizard)

(defspel splash-wizard (game-state)
  `(do-splash 'wizard 'bucket ,game-state))

(defun init-state ()
  (make-state
    objects objects
    places (list living-room garden attic netherworld)
    player-location 'living-room
    goals goals))

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
  (let ((state (init-state)))
    (display-scene state)
    state))

(defun hope-for-mercy (state)
  (if (> 0.25 (random:uniform))
        (spell-of-mercy)
        state))

(defun loop-server (state)
  (receive
    (`#(look)
      (display-scene state)
      (case (state-player-location state)
        ('netherworld (loop-server (hope-for-mercy state)))
        (_ (loop-server state))))
    (`#(exits)
      (display-exits state)
      (loop-server state))
    (`#(go ,direction)
      (loop-server (walk-direction direction state)))
    (`#(take ,item)
      (loop-server (pickup-item item state)))
    (`#(inv)
      (display-inv state)
      (loop-server state))
    (`#(weld ,subj ,obj)
      (loop-server (do-weld subj obj state)))
    (`#(dunk ,subj ,obj)
      (loop-server (do-dunk subj obj state)))
    (`#(splash ,subj ,obj)
      (loop-server (do-splash subj obj state)))))

(defun loop-server ()
  (loop-server (init-state)))

(defun start ()
  (case (whereis 'game-server)
    ('undefined
      (let ((server-pid (spawn #'loop-server/0)))
        (register 'game-server server-pid)
        '#(status started)))
    (_ '#(status already-started))))

(defun stop
  (('undefined _)
    '#(status already-stopped))
  ((pid msg)
    (exit pid msg)
    `#(status ,msg)))

(defun stop ()
  (stop (whereis 'game-server) 'game-over))

(defspel sent-prompt ()
  '(list_to_atom (string:copies "-" 78)))

(defspel send (args)
  `(progn
    (! (whereis 'game-server) ,args)
    ',(sent-prompt)))

(defspel go (direction)
  `(send #(go ,direction)))

(defspel look ()
  `(send #(look)))

(defspel exits ()
  `(send #(exits)))

(defspel inv ()
  `(send #(inv)))

(defspel take (item)
  `(send #(take ,item)))

(defspel weld (subj obj)
  `(send #(weld ,subj ,obj)))

(defspel dunk (subj obj)
  `(send #(dunk ,subj ,obj)))

(defspel splash (subj obj)
  `(send #(splash ,subj ,obj)))

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

(defun display-scene (game-state)
  (io:format
    "~n~s~s~s"
    (lists:map
      #'wrap-text/1
      `(,(describe-location game-state)
        ,(describe-items game-state)
        ,(describe-exits game-state)))))

(defun display-exits (game-state)
  (io:format
    "~n~s"
    (list (wrap-text (describe-exits game-state)))))

(defun game-data-loaded ()
  "This is a dummy function; it's only here to display a message (the name of
  the function) in the REPL after loading this file."
  'noop)
