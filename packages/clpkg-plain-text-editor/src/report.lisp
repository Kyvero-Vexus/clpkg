(in-package #:clpkg-plain-text-editor)

(defun generate-report (checks)
  (declare (type list checks))
  (make-plaintext-report
   :checks checks
   :summary (format nil "~d checks" (length checks))))
