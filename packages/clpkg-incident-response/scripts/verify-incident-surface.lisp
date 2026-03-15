(defun slurp (p) (with-open-file (in p) (let ((s (make-string (file-length in)))) (read-sequence s in) s)))
(defun chk (p ns) (let ((c (slurp p))) (dolist (n ns) (unless (search n c :test #'char=) (error "Missing ~S" n)) (format t "  PASS: ~S~%" n))))
(format t "=== Incident Response ADTs ===~%")
(chk "/home/slime/projects/clpkg-incident-response/src/core/incident-types.coal"
     '("module Core.IncidentTypes" "data Severity" "data IncidentStatus" "data Incident"
       "data TimelineEntry" "data TimelineAction" "data EscalationLevel" "data EscalationPolicy"
       "data Responder" "data ResponderRole" "data Evidence" "data EvidenceType"
       "data Playbook" "data PostMortem" "data IncidentResult"
       "incident-open-p" "incident-age-hours" "escalation-needed-p" "evidence-count"))
(format t "=== ALL 19 CHECKS PASSED ===~%") (sb-ext:exit :code 0)
