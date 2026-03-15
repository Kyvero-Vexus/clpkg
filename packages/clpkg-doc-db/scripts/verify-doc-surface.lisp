(defun slurp (p) (with-open-file (in p) (let ((s (make-string (file-length in)))) (read-sequence s in) s)))
(defun chk (p ns) (let ((c (slurp p))) (dolist (n ns) (unless (search n c :test #'char=) (error "Missing ~S" n)) (format t "  PASS: ~S~%" n))))
(format t "=== Doc DB ADTs ===~%")
(chk "/home/slime/projects/clpkg-doc-db/src/core/doc-types.coal"
     '("module Core.DocTypes" "data JsonValue" "data Document" "data Collection"
       "data DocQuery" "data QueryOperator" "data SortOrder" "data SortField"
       "data Projection" "data DocIndex" "data IndexType" "data WriteResult"
       "data BulkOperation" "data ChangeEvent" "data DocResult"
       "document-has-field" "collection-count" "query-has-filter" "sort-ascending-p"))
(format t "=== ALL 19 CHECKS PASSED ===~%") (sb-ext:exit :code 0)
