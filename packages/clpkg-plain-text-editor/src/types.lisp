(in-package #:clpkg-plain-text-editor)

(declaim (optimize (speed 2) (safety 3) (debug 3)))

(defstruct (plaintext-config (:constructor make-plaintext-config (&key root (encoding :utf-8))))
  (root "." :type string)
  (encoding :utf-8 :type keyword))

(defstruct (text-buffer-snapshot (:constructor make-text-buffer-snapshot (&key path content)))
  (path "" :type string)
  (content "" :type string))

(defstruct (text-edit-op (:constructor make-text-edit-op (&key start end replacement)))
  (start 0 :type fixnum)
  (end 0 :type fixnum)
  (replacement "" :type string))

(defstruct (search-result (:constructor make-search-result (&key start end snippet)))
  (start 0 :type fixnum)
  (end 0 :type fixnum)
  (snippet "" :type string))

(defstruct (text-diagnostic (:constructor make-text-diagnostic (&key code message severity offset)))
  (code "" :type string)
  (message "" :type string)
  (severity :info :type keyword)
  (offset 0 :type fixnum))

(defstruct (plaintext-report (:constructor make-plaintext-report (&key checks summary)))
  (checks nil :type list)
  (summary "" :type string))
