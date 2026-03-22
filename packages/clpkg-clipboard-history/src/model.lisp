(in-package #:clpkg-clipboard-history)

(defstruct (clipboard-entry (:conc-name ce-))
  (entry-id "" :type string)
  (text "" :type string)
  (tags '() :type list)
  (created-at 0 :type integer)
  (content-hash 0 :type integer))

(defstruct (clipboard-store (:conc-name cs-))
  (limit 50 :type integer)
  (entries '() :type list))
