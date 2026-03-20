(in-package #:clpkg-plain-text-editor)

(defun apply-edit (snapshot edit-op)
  (declare (type text-buffer-snapshot snapshot)
           (type text-edit-op edit-op))
  (let* ((content (text-buffer-snapshot-content snapshot))
         (start (text-edit-op-start edit-op))
         (end (text-edit-op-end edit-op))
         (replacement (text-edit-op-replacement edit-op)))
    (unless (%validate-range content start end)
      (error "Invalid edit range: ~a..~a for content length ~a" start end (length content)))
    (make-text-buffer-snapshot
     :path (text-buffer-snapshot-path snapshot)
     :content (concatenate 'string
                           (subseq content 0 start)
                           replacement
                           (subseq content end)))))
