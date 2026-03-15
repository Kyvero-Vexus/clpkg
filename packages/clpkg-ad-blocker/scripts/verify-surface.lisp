(defun slurp (p) (with-open-file (in p) (let ((s (make-string (file-length in)))) (read-sequence s in) s)))
(defun chk (p ns) (let ((c (slurp p))) (dolist (n ns) (unless (search n c :test #'char=) (error "Missing ~S" n)) (format t "  PASS: ~S~%" n))))
(chk "/home/slime/projects/clpkg-ad-blocker/src/core/blocker-types.coal" '("module Core.BlockerTypes" "data FilterType" "data FilterRule" "data FilterList" "data BlockAction" "data BlockResult" "data RequestType" "data ContentPolicy" "data Whitelist" "data Statistics" "data CosmeticRule" "data ScriptletInjection" "data DnsBlockEntry" "data UpdateSchedule" "data BlockerResult" "rule-is-block" "request-blocked-p" "block-rate-pct" "list-rule-count"))
(format t "=== ALL PASSED ===~%") (sb-ext:exit :code 0)
