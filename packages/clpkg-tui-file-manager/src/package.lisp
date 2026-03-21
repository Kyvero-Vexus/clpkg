(defpackage #:clpkg-tui-file-manager
  (:use #:cl)
  (:export
   #:file-entry #:file-entry-p #:make-file-entry
   #:file-state #:file-state-p #:make-file-state
   #:selection-state #:selection-state-p #:make-selection-state
   #:sort-entries-deterministic
   #:apply-navigation-event))
