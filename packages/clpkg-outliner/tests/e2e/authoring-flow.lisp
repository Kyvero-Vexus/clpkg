(require "asdf")
(asdf:load-asd (truename "clpkg-outliner.asd"))
(asdf:load-system :clpkg-outliner)

(let* ((doc (clpkg-outliner:make-empty-document))
       (tmp (merge-pathnames "artifacts/e2e-roundtrip.sexp" (truename "./"))))
  (clpkg-outliner:insert-node doc 0 1 "Plan")
  (clpkg-outliner:insert-node doc 1 2 "Detail" "typed core")
  (assert (clpkg-outliner:check-invariants doc))
  (clpkg-outliner:save-document doc tmp)
  (let ((loaded (clpkg-outliner:load-document tmp)))
    (assert (clpkg-outliner:check-invariants loaded))
    (assert (equal "typed core"
                   (clpkg-outliner:node-body
                    (gethash 2 (clpkg-outliner:document-nodes loaded))))))
  (format t "E2E PASS: ~a~%" tmp))
