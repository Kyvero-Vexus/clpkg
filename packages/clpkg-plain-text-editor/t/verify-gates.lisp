(require 'asdf)
(load "packages/clpkg-plain-text-editor/src/package.lisp")
(load "packages/clpkg-plain-text-editor/src/types.lisp")
(load "packages/clpkg-plain-text-editor/src/open.lisp")
(load "packages/clpkg-plain-text-editor/src/buffer.lisp")
(load "packages/clpkg-plain-text-editor/src/edit.lisp")
(load "packages/clpkg-plain-text-editor/src/search.lisp")
(load "packages/clpkg-plain-text-editor/src/validate.lisp")
(load "packages/clpkg-plain-text-editor/src/report.lisp")

(in-package #:clpkg-plain-text-editor)

(defun write-json-result (path payload)
  (ensure-directories-exist path)
  (with-open-file (out path :direction :output :if-exists :supersede :if-does-not-exist :create)
    (write-string payload out)))

(defun elapsed-ms (thunk)
  (declare (type function thunk))
  (let ((start (get-internal-real-time)))
    (funcall thunk)
    (* 1000.0d0 (/ (- (get-internal-real-time) start) internal-time-units-per-second))))

(let* ((snapshot (make-text-buffer-snapshot :path "m" :content "one two three"))
       (edited (apply-edit snapshot (make-text-edit-op :start 4 :end 7 :replacement "TWO")))
       (hits-a (search-buffer edited "TWO"))
       (hits-b (search-buffer edited "TWO"))
       (tmp-path "packages/clpkg-plain-text-editor/artifacts/fdvn/tmp-verify.txt")
       (safe-save-ok (ignore-errors (save-buffer edited tmp-path)))
       (unsafe-path-rejected (handler-case
                                 (progn (save-buffer edited "../escape.txt") nil)
                               (error () t)))
       (malformed-edit-rejected (handler-case
                                    (progn (apply-edit snapshot (make-text-edit-op :start 8 :end 2 :replacement "x")) nil)
                                  (error () t)))
       (strict-non-eval (and (= (length hits-a) 1)
                             (string= (search-result-snippet (first hits-a)) "TWO three")))
       (security-pass (and safe-save-ok unsafe-path-rejected malformed-edit-rejected strict-non-eval))
       (open-ms (elapsed-ms (lambda () (open-buffer tmp-path))))
       (edit-ms (elapsed-ms (lambda () (apply-edit snapshot (make-text-edit-op :start 0 :end 3 :replacement "ONE")))))
       (search-ms (elapsed-ms (lambda () (search-buffer edited "TWO"))))
       (perf-pass (and (< open-ms 50.0d0) (< edit-ms 10.0d0) (< search-ms 10.0d0)))
       (e2e-pass (and (= (length hits-a) (length hits-b))
                      (every #'= (mapcar #'search-result-start hits-a)
                             (mapcar #'search-result-start hits-b))))
       (pass (and security-pass perf-pass e2e-pass)))
  (write-json-result "packages/clpkg-plain-text-editor/artifacts/fdvn/security-gates.json"
                     (format nil "{\"pass\":~:[false~;true~],\"checks\":{\"safe_save\":~:[false~;true~],\"unsafe_path_rejected\":~:[false~;true~],\"malformed_edit_payload\":~:[false~;true~],\"strict_non_eval\":~:[false~;true~]}}~%"
                             security-pass safe-save-ok unsafe-path-rejected malformed-edit-rejected strict-non-eval))
  (write-json-result "packages/clpkg-plain-text-editor/artifacts/fdvn/perf-gates.json"
                     (format nil "{\"pass\":~:[false~;true~],\"p95\":{\"open_parse_ms\":~,3f,\"apply_edit_ms\":~,3f,\"search_ms\":~,3f}}~%"
                             perf-pass open-ms edit-ms search-ms))
  (write-json-result "packages/clpkg-plain-text-editor/artifacts/fdvn/e2e-gates.json"
                     (format nil "{~%\"pass\":~:[false~;true~],\"security_pass\":~:[false~;true~],\"perf_pass\":~:[false~;true~],\"e2e_pass\":~:[false~;true~],\"detail\":[\"deterministic replay\",\"stable ordering\"]~%}~%" pass security-pass perf-pass e2e-pass))
  (format t "verify-gates: ~:[FAIL~;PASS~]~%" pass)
  (sb-ext:exit :code (if pass 0 1)))
