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

(let* ((base (make-text-buffer-snapshot :path "mem" :content "alpha beta gamma"))
       (edit (make-text-edit-op :start 6 :end 10 :replacement "BETA"))
       (edited-1 (apply-edit base edit))
       (edited-2 (apply-edit base edit))
       (hash-eq (string= (text-buffer-snapshot-content edited-1)
                         (text-buffer-snapshot-content edited-2)))
       (invalid-range-rejection
         (handler-case
             (progn
               (apply-edit base (make-text-edit-op :start 99 :end 100 :replacement "x"))
               nil)
           (error () t)))
       (ordered-search
         (let ((hits (search-buffer (make-text-buffer-snapshot :path "m" :content "aba aba") "aba")))
           (and (= 2 (length hits))
                (< (search-result-start (first hits)) (search-result-start (second hits))))))
       (all-pass (and hash-eq invalid-range-rejection ordered-search)))
  (write-json-result
   "packages/clpkg-plain-text-editor/artifacts/fdvn/contracts/contracts-result.json"
   (format nil
           "{~%  \"pass\": ~:[false~;true~],~%  \"checks\": {~%    \"edit_replay_hash\": ~:[false~;true~],~%    \"invalid_range_rejection\": ~:[false~;true~],~%    \"search_ordering\": ~:[false~;true~]~%  }~%}~%"
           all-pass hash-eq invalid-range-rejection ordered-search))
  (format t "contracts: ~:[FAIL~;PASS~]~%" all-pass)
  (sb-ext:exit :code (if all-pass 0 1)))
