(defun slurp (p) (with-open-file (in p) (let ((s (make-string (file-length in)))) (read-sequence s in) s)))
(defun chk (p ns) (let ((c (slurp p))) (dolist (n ns) (unless (search n c :test #'char=) (error "Missing ~S" n)) (format t "  PASS: ~S~%" n))))
(format t "=== SIEM ADTs ===~%")
(chk "/home/slime/projects/clpkg-siem/src/core/siem-types.coal"
     '("module Core.SiemTypes" "data LogSource" "data LogSourceType" "data NormalizedEvent"
       "data EventCategory" "data DetectionRule" "data RuleLogic" "data AlertPriority"
       "data Alert" "data AlertStatus" "data CorrelationRule" "data Dashboard"
       "data DashboardWidget" "data WidgetType" "data SiemResult"
       "event-is-security" "alert-active-p" "rule-matches-category" "dashboard-widget-count"))
(format t "=== ALL 19 CHECKS PASSED ===~%") (sb-ext:exit :code 0)
