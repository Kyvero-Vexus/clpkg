;;; verify-secret-surface.lisp

(defun slurp (path)
  (with-open-file (in path :direction :input)
    (let ((s (make-string (file-length in))))
      (read-sequence s in) s)))

(defun must-contain (content needle path)
  (unless (search needle content :test #'char=)
    (error "Missing ~S in ~A" needle path))
  (format t "  PASS: ~S~%" needle))

(defun check-file (path needles)
  (unless (probe-file path) (error "Missing: ~A" path))
  (let ((c (slurp path))) (dolist (n needles) (must-contain c n path))))

(format t "=== Secret Manager ADTs Surface Check ===~%")
(check-file "/home/slime/projects/clpkg-secret-manager/src/core/secret-types.coal"
            '("module Core.SecretTypes"
              "data EncryptionAlgorithm" "data SecretVersion" "data SecretEntry"
              "data SecretMetadata" "data VaultBackendType" "data VaultBackend"
              "data AccessLevel" "data AccessPolicy"
              "data RotationFrequency" "data RotationSchedule"
              "data AuditAction" "data AuditEvent" "data SecretResult"
              "secret-is-active" "secret-age-days"
              "rotation-due-p" "access-permitted-p"))

(format t "=== ALL 17 CHECKS PASSED ===~%")
(sb-ext:exit :code 0)
