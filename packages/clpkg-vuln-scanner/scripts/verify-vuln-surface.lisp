(defun slurp (p) (with-open-file (in p) (let ((s (make-string (file-length in)))) (read-sequence s in) s)))
(defun chk (p ns) (let ((c (slurp p))) (dolist (n ns) (unless (search n c :test #'char=) (error "Missing ~S" n)) (format t "  PASS: ~S~%" n))))
(chk "/home/slime/projects/clpkg-vuln-scanner/src/core/vuln-types.coal"
     '("module Core.VulnTypes" "data VulnSeverity" "data CvssScore" "data Vulnerability"
       "data ScanTarget" "data TargetType" "data ScanPolicy" "data ScanStatus"
       "data ScanResult" "data Finding" "data Remediation" "data RemediationPriority"
       "data ComplianceCheck" "data ComplianceStatus" "data VulnResult"
       "vuln-is-critical" "scan-complete-p" "finding-count" "remediation-overdue-p"))
(format t "=== 19/19 PASSED ===~%") (sb-ext:exit :code 0)
