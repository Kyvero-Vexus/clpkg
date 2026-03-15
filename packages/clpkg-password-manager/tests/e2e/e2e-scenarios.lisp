(defun slurp (p) (with-open-file (in p) (let ((s (make-string (file-length in)))) (read-sequence s in) s)))
(defun chk (p ns) (let ((c (slurp p))) (dolist (n ns) (unless (search n c :test #'char=) (error "Missing ~S" n)) (format t "  PASS: ~S~%" n))))
(chk "/home/slime/projects/clpkg-password-manager/src/core/pwd-types.coal" '("module Core.PwdTypes" "data EncryptionScheme" "data KdfAlgorithm" "data VaultStatus" "data Vault" "data EntryType" "data PasswordEntry" "data PasswordStrength" "data GeneratorConfig" "data AutofillHint" "data BreachStatus" "data SharingPermission" "data SharedEntry" "data AuditLogEntry" "data PwdResult" "vault-locked-p" "entry-is-login" "password-strong-p" "breach-detected-p"))
(format t "=== ALL PASSED ===~%") (sb-ext:exit :code 0)
