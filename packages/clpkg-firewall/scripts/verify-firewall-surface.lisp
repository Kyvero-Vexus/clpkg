(defun slurp (p) (with-open-file (in p) (let ((s (make-string (file-length in)))) (read-sequence s in) s)))
(defun chk (p ns) (let ((c (slurp p))) (dolist (n ns) (unless (search n c :test #'char=) (error "Missing ~S" n)) (format t "  PASS: ~S~%" n))))
(chk "/home/slime/projects/clpkg-firewall/src/core/firewall-types.coal"
     '("module Core.FirewallTypes" "data Protocol" "data PortRange" "data RuleAction"
       "data RuleDirection" "data FirewallRule" "data RuleChain" "data ChainPolicy"
       "data Zone" "data NatType" "data NatRule" "data RateLimitRule"
       "data ConnectionState" "data FirewallConfig" "data FirewallResult"
       "rule-permits-p" "chain-rule-count" "nat-is-snat" "port-in-range"))
(format t "=== 19/19 PASSED ===~%") (sb-ext:exit :code 0)
