;;; verify-iac-surface.lisp

(defun slurp (path)
  (with-open-file (in path :direction :input)
    (let ((s (make-string (file-length in))))
      (read-sequence s in) s)))

(defun must-contain (content needle path)
  (unless (search needle content :test #'char=)
    (error "Missing ~S in ~A" needle path))
  (format t "  PASS: ~S~%" needle))

(defun check-file (path needles)
  (unless (probe-file path) (error "Missing: ~A" path))
  (let ((c (slurp path))) (dolist (n needles) (must-contain c n path))))

(format t "=== IaC Runner ADTs Surface Check ===~%")
(check-file "/home/slime/projects/clpkg-iac-runner/src/core/iac-types.coal"
            '("module Core.IacTypes"
              "data ResourceType" "data ResourceState" "data ResourceSpec"
              "data PlanActionType" "data PlanAction" "data ExecutionPlan"
              "data ApplyStatus" "data ApplyResult"
              "data DriftSeverity" "data DriftEntry" "data DriftReport"
              "data ProviderType" "data ProviderConfig" "data StateBackend"
              "data IacResult"
              "resource-needs-update" "plan-action-count"
              "drift-has-breaking" "apply-succeeded-p"))

(format t "=== ALL 19 CHECKS PASSED ===~%")
(sb-ext:exit :code 0)
