(defun slurp (p) (with-open-file (in p) (let ((s (make-string (file-length in)))) (read-sequence s in) s)))
(defun chk (p ns) (let ((c (slurp p))) (dolist (n ns) (unless (search n c :test #'char=) (error "Missing ~S" n)) (format t "  PASS: ~S~%" n))))
(chk "/home/slime/projects/clpkg-endpoint-protection/src/core/epp-types.coal"
     '("module Core.EppTypes" "data ThreatType" "data ThreatSeverity" "data Detection"
       "data DetectionAction" "data ScanType" "data ScanSchedule" "data QuarantineEntry"
       "data ExclusionRule" "data ExclusionType" "data PolicyEnforcement"
       "data DeviceStatus" "data AgentHealth" "data ThreatIntel" "data EppResult"
       "detection-is-malware" "quarantine-age-hours" "agent-healthy-p" "threat-score-high-p"))
(format t "=== 19/19 PASSED ===~%") (sb-ext:exit :code 0)
