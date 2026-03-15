(defun slurp (p) (with-open-file (in p) (let ((s (make-string (file-length in)))) (read-sequence s in) s)))
(defun chk (p ns) (let ((c (slurp p))) (dolist (n ns) (unless (search n c :test #'char=) (error "Missing ~S" n)) (format t "  PASS: ~S~%" n))))
(chk "/home/slime/projects/clpkg-mfa-auth/src/core/mfa-types.coal" '("module Core.MfaTypes" "data OtpAlgorithm" "data TotpConfig" "data HotpConfig" "data MfaMethod" "data MfaAccount" "data OtpCode" "data BackupCode" "data QrPayload" "data ExportFormat" "data MfaGroup" "data SyncStatus" "data AuthEvent" "data MfaConfig" "data MfaResult" "totp-time-remaining" "account-is-totp" "backup-code-used-p" "group-account-count"))
(format t "=== ALL PASSED ===~%") (sb-ext:exit :code 0)
