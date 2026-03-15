(defun slurp (p) (with-open-file (in p) (let ((s (make-string (file-length in)))) (read-sequence s in) s)))
(defun chk (p ns) (let ((c (slurp p))) (dolist (n ns) (unless (search n c :test #'char=) (error "Missing ~S" n)) (format t "  PASS: ~S~%" n))))
(chk "/home/slime/projects/clpkg-vpn-client/src/core/vpn-types.coal"
     '("module Core.VpnTypes" "data VpnProtocol" "data TunnelState" "data VpnConfig"
       "data Endpoint" "data Certificate" "data CertStatus" "data DnsConfig"
       "data SplitTunnelRule" "data SplitTunnelMode" "data ConnectionStats"
       "data VpnProfile" "data KillSwitchMode" "data VpnEvent" "data VpnResult"
       "tunnel-connected-p" "cert-valid-p" "connection-uptime-secs" "kill-switch-active-p"))
(format t "=== 19/19 PASSED ===~%") (sb-ext:exit :code 0)
