(defpackage #:clpkg-clipboard-history
  (:use #:cl)
  (:export
   #:clipboard-entry #:clipboard-entry-p #:make-clipboard-entry
   #:clipboard-store #:clipboard-store-p #:make-clipboard-store
   #:append-entry
   #:store->newest-first
   #:query-substring))
