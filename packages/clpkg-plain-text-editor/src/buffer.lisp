(in-package #:clpkg-plain-text-editor)

(defun %validate-range (content start end)
  (declare (type string content) (type fixnum start end))
  (and (<= 0 start) (<= start end) (<= end (length content))))
