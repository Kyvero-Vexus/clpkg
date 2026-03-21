(defpackage #:clpkg-shell-prompt-theme-manager
  (:use #:cl)
  (:export
   #:prompt-theme #:prompt-theme-p #:make-prompt-theme
   #:prompt-context #:prompt-context-p #:make-prompt-context
   #:rendered-prompt #:rendered-prompt-p #:make-rendered-prompt
   #:render-static-prompt
   #:render-prompt-line))
