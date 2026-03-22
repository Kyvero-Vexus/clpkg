(defpackage #:clpkg-terminal-emulator
  (:use #:cl)
  (:export
   #:terminal-cell #:terminal-cell-p #:make-terminal-cell
   #:terminal-screen #:terminal-screen-p #:make-terminal-screen
   #:screen-write-char
   #:screen->lines
   #:screen-cursor-row
   #:screen-cursor-col))
