(defpackage #:clpkg-serial-console-client
  (:use #:cl)
  (:export
   #:serial-port-profile #:serial-port-profile-p #:make-serial-port-profile
   #:serial-session #:serial-session-p #:make-serial-session
   #:serial-connection-state
   #:build-serial-session-summary))
