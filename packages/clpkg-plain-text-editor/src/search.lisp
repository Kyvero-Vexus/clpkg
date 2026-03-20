(in-package #:clpkg-plain-text-editor)

(defun search-buffer (snapshot needle)
  (declare (type text-buffer-snapshot snapshot)
           (type string needle))
  (let ((content (text-buffer-snapshot-content snapshot))
        (results '())
        (pos 0)
        (len (length needle)))
    (loop
      for found = (search needle content :start2 pos)
      while found do
        (push (make-search-result :start found :end (+ found len)
                                  :snippet (subseq content found (min (length content) (+ found len 16))))
              results)
        (setf pos (+ found (max 1 len))))
    (sort results #'< :key #'search-result-start)))
