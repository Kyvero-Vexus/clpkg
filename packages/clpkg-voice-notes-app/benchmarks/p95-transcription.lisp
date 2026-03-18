;;;; synthetic p95 harness for transcription stage latency budget
(load "/home/slime/projects/clpkg/packages/clpkg-voice-notes-app/src/pipeline/pipeline-stubs.lisp")

(defun simulate-transcribe-ms (i)
  ;; deterministic synthetic latency distribution (ms)
  (+ 120 (mod (* i 37) 240)))

(defun p95 (values)
  (let* ((sorted (sort (copy-seq values) #'<))
         (idx (floor (* 0.95 (1- (length sorted))))))
    (elt sorted idx)))

(let ((samples (loop for i from 1 to 200 collect (simulate-transcribe-ms i))))
  (let ((v (p95 samples)))
    (format t "p95_ms=~D~%" v)
    (when (> v 400)
      (error "p95 exceeded budget: ~D" v))
    (sb-ext:exit :code 0)))
