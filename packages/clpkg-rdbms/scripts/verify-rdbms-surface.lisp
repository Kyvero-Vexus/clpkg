(defun slurp (p) (with-open-file (in p) (let ((s (make-string (file-length in)))) (read-sequence s in) s)))
(defun chk (p ns) (let ((c (slurp p))) (dolist (n ns) (unless (search n c :test #'char=) (error "Missing ~S" n)) (format t "  PASS: ~S~%" n))))
(format t "=== RDBMS ADTs ===~%")
(chk "/home/slime/projects/clpkg-rdbms/src/core/rdbms-types.coal"
     '("module Core.RdbmsTypes" "data SqlType" "data ColumnConstraint" "data ColumnDef"
       "data TableDef" "data ForeignKey" "data IndexDef" "data SqlValue" "data Row"
       "data ResultSet" "data TransactionIsolation" "data Transaction"
       "data QueryPlan" "data PlanNodeType" "data RdbmsResult"
       "column-nullable-p" "resultset-empty-p" "table-column-count" "plan-estimated-rows"))
(format t "=== ALL 19 CHECKS PASSED ===~%") (sb-ext:exit :code 0)
