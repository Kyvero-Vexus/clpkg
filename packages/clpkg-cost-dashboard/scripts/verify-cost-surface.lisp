;;; verify-cost-surface.lisp

(defun slurp (path)
  (with-open-file (in path :direction :input)
    (let ((s (make-string (file-length in))))
      (read-sequence s in)
      s)))

(defun must-contain (content needle path)
  (unless (search needle content :test #'char=)
    (error "Missing ~S in ~A" needle path))
  (format t "  PASS: ~S~%" needle))

(defun check-file (path needles)
  (unless (probe-file path)
    (error "Missing file: ~A" path))
  (let ((c (slurp path)))
    (dolist (n needles) (must-contain c n path))))

(format t "=== Cost Governance ADTs Surface Check ===~%")
(check-file "/home/slime/projects/clpkg-cost-dashboard/src/core/cost-types.coal"
            '("module Core.CostTypes"
              "data Currency" "data MoneyAmount" "data BillingPeriod"
              "data ResourceTag" "data SpendEntry" "data Budget"
              "data BudgetStatus" "data CostForecast" "data ForecastMethod"
              "data AlertThreshold" "data AlertAction" "data CostReport"
              "data CostResult"
              "money-to-cents" "budget-remaining-pct"
              "spend-total-cents" "threshold-exceeded-p"))

(format t "=== ALL 17 CHECKS PASSED ===~%")
(sb-ext:exit :code 0)
