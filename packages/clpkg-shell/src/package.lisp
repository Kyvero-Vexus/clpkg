(defpackage #:clpkg-shell
  (:use #:cl)
  (:export
   #:shell-session #:shell-session-p #:make-shell-session
   #:command-result #:command-result-p #:make-command-result
   #:shell-state
   #:spawn-shell-session
   #:run-shell-command
   #:shell-session-summary))
