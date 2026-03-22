;;; verify-core.lisp — Core verification gate for clpkg-clipboard-history
;;; Run from repo root: sbcl --script packages/clpkg-clipboard-history/scripts/verify-core.lisp
;;; Outputs JSON pass/fail result and exits 0 on pass, 1 on failure.

(load "packages/clpkg-clipboard-history/src/package.lisp")
(load "packages/clpkg-clipboard-history/src/model.lisp")
(load "packages/clpkg-clipboard-history/src/store.lisp")
(in-package #:clpkg-clipboard-history)

(defvar *failures* '())

(defmacro check (name form)
  `(handler-case
       (if ,form
           (format t "  PASS ~A~%" ,name)
           (progn
             (push ,name *failures*)
             (format t "  FAIL ~A~%" ,name)))
     (error (e)
       (push ,name *failures*)
       (format t "  ERROR ~A: ~A~%" ,name e))))

;;; --- Test suite ---

;; 1. Basic store construction
(let ((s (make-clipboard-store :limit 5 :entries '())))
  (check "store-construction" (= (cs-limit s) 5))
  (check "store-empty-initially" (null (cs-entries s))))

;; 2. Append and retrieve
(let* ((s (make-clipboard-store :limit 5 :entries '()))
       (e (make-clipboard-entry :entry-id "a1" :text "hello" :created-at 100 :content-hash 42))
       (s1 (append-entry s e)))
  (check "append-single" (= (length (cs-entries s1)) 1))
  (check "entry-text" (string= (ce-text (first (cs-entries s1))) "hello")))

;; 3. Bounded retention (limit enforcement)
(let* ((s (make-clipboard-store :limit 2 :entries '()))
       (e1 (make-clipboard-entry :entry-id "1" :text "one"   :created-at 1 :content-hash 1))
       (e2 (make-clipboard-entry :entry-id "2" :text "two"   :created-at 2 :content-hash 2))
       (e3 (make-clipboard-entry :entry-id "3" :text "three" :created-at 3 :content-hash 3))
       (s3 (append-entry (append-entry (append-entry s e1) e2) e3)))
  (check "bounded-retention-count" (= (length (cs-entries s3)) 2))
  (check "bounded-retention-newest" (string= (ce-entry-id (first (store->newest-first s3))) "3")))

;; 4. Query substring
(let* ((s (make-clipboard-store :limit 10 :entries '()))
       (e1 (make-clipboard-entry :entry-id "x1" :text "foo bar" :created-at 1 :content-hash 10))
       (e2 (make-clipboard-entry :entry-id "x2" :text "baz qux" :created-at 2 :content-hash 20))
       (s2 (append-entry (append-entry s e1) e2))
       (results (query-substring s2 "foo")))
  (check "query-substring-match" (= (length results) 1))
  (check "query-substring-id"    (string= (ce-entry-id (first results)) "x1")))

;; 5. Newest-first ordering
(let* ((s (make-clipboard-store :limit 10 :entries '()))
       (e1 (make-clipboard-entry :entry-id "t1" :text "first"  :created-at 10 :content-hash 100))
       (e2 (make-clipboard-entry :entry-id "t2" :text "second" :created-at 20 :content-hash 200))
       (s2 (append-entry (append-entry s e1) e2))
       (ordered (store->newest-first s2)))
  (check "newest-first-order" (string= (ce-entry-id (first ordered)) "t2")))

;;; --- Result output ---
(terpri)
(let ((pass-count (- 9 (length *failures*)))
      (total 9))
  (if (null *failures*)
      (progn
        (format t "{\"status\":\"pass\",\"passed\":~A,\"failed\":0,\"package\":\"clpkg-clipboard-history\"}~%"
                total)
        (sb-ext:exit :code 0))
      (progn
        (format t "{\"status\":\"fail\",\"passed\":~A,\"failed\":~A,\"failures\":~S,\"package\":\"clpkg-clipboard-history\"}~%"
                pass-count (length *failures*)
                (format nil "~{~A~^,~}" (reverse *failures*)))
        (sb-ext:exit :code 1))))
