(in-package #:clpkg-tui-file-manager)

(defstruct (file-entry (:conc-name fe-))
  (path "" :type string)
  (kind :file :type keyword)
  (size-bytes 0 :type integer)
  (modified-at 0 :type integer))

(defstruct (selection-state (:conc-name ss-))
  (cursor-path "" :type string)
  (marked-paths '() :type list))

(defstruct (file-state (:conc-name fs-))
  (cwd "" :type string)
  (entries '() :type list)
  (selection (make-selection-state) :type selection-state))

(defun sort-entries-deterministic (entries)
  (declare (type list entries) (optimize (safety 3)))
  (sort (copy-list entries)
        (lambda (a b)
          (declare (type file-entry a b))
          (string< (fe-path a) (fe-path b)))))

(defun apply-navigation-event (state new-cursor)
  (declare (type file-state state)
           (type string new-cursor)
           (optimize (safety 3)))
  (make-file-state
   :cwd (fs-cwd state)
   :entries (sort-entries-deterministic (fs-entries state))
   :selection (make-selection-state
               :cursor-path new-cursor
               :marked-paths (ss-marked-paths (fs-selection state)))))
