;;; verify-query-surface.lisp
(defun slurp (p) (with-open-file (in p) (let ((s (make-string (file-length in)))) (read-sequence s in) s)))
(defun chk (p ns) (unless (probe-file p) (error "Missing: ~A" p))
  (let ((c (slurp p))) (dolist (n ns) (unless (search n c :test #'char=) (error "Missing ~S in ~A" n p)) (format t "  PASS: ~S~%" n))))

(format t "=== Query IDE ADTs ===~%")
(chk "/home/slime/projects/clpkg-query-ide/src/core/query-types.coal"
     '("module Core.QueryTypes"
       "data ColumnType" "data ColumnDef" "data ResultSet"
       "data QueryLanguage" "data Query" "data QueryStatus"
       "data ConnectionDriver" "data Connection"
       "data SchemaObject" "data SchemaInfo"
       "data PlanNode" "data ExecutionPlan"
       "data HistoryEntry" "data QueryResult"
       "resultset-row-count" "query-is-readonly"
       "connection-active-p" "plan-estimated-cost"))
(format t "=== ALL 18 CHECKS PASSED ===~%")
(sb-ext:exit :code 0)
