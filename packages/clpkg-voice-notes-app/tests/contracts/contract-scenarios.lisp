;;;; baseline contract checks for clpkg-voice-notes-app
(load "/home/slime/projects/clpkg/packages/clpkg-voice-notes-app/src/pipeline/pipeline-stubs.lisp")

(defun assert-eq (expected actual)
  (unless (equal expected actual)
    (error "Assertion failed: expected ~S, got ~S" expected actual)))

(let* ((ingest (clpkg-voice-notes-app.pipeline:ingest-note "file:///tmp/sample.wav"))
       (transcribe (clpkg-voice-notes-app.pipeline:transcribe-note (cdr ingest)))
       (validate (clpkg-voice-notes-app.pipeline:validate-note (cdr transcribe)))
       (index (clpkg-voice-notes-app.pipeline:index-note (cdr validate)))
       (emit (clpkg-voice-notes-app.pipeline:emit-note (cdr index))))
  (assert-eq :ok (car ingest))
  (assert-eq :ok (car transcribe))
  (assert-eq :ok (car validate))
  (assert-eq :ok (car index))
  (assert-eq :ok (car emit))
  (format t "=== CONTRACT SCENARIOS PASSED ===~%")
  (sb-ext:exit :code 0))
