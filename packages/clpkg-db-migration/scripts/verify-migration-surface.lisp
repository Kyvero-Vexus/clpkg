;;; verify-migration-surface.lisp
(defun slurp (p) (with-open-file (in p) (let ((s (make-string (file-length in)))) (read-sequence s in) s)))
(defun chk (p ns) (unless (probe-file p) (error "Missing: ~A" p))
  (let ((c (slurp p))) (dolist (n ns) (unless (search n c :test #'char=) (error "Missing ~S in ~A" n p)) (format t "  PASS: ~S~%" n))))
(format t "=== DB Migration ADTs ===~%")
(chk "/home/slime/projects/clpkg-db-migration/src/core/migration-types.coal"
     '("module Core.MigrationTypes"
       "data MigrationDirection" "data MigrationStatus" "data MigrationStep"
       "data MigrationPlan" "data SchemaVersion" "data ColumnChange"
       "data TableChange" "data IndexChange" "data SchemaDiff"
       "data RollbackStrategy" "data MigrationConfig" "data MigrationLog"
       "data LockStatus" "data MigrationResult"
       "migration-pending-p" "plan-step-count" "diff-has-destructive" "version-newer-p"))
(format t "=== ALL 18 CHECKS PASSED ===~%")
(sb-ext:exit :code 0)
