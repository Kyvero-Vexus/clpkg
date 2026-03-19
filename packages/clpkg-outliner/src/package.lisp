(defpackage #:clpkg-outliner
  (:use #:cl)
  (:export
   #:outline-error
   #:outline-parse-error
   #:outline-invariant-error
   #:node
   #:node-id
   #:node-parent
   #:node-children
   #:node-title
   #:node-body
   #:document
   #:document-version
   #:document-nodes
   #:make-empty-document
   #:insert-node
   #:check-invariants
   #:document->sexp
   #:sexp->document
   #:save-document
   #:load-document))
