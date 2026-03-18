(defpackage #:clpkg-voice-notes-app.security
  (:use #:cl)
  (:export #:safe-media-path-p #:allowed-audio-extension-p))

(in-package #:clpkg-voice-notes-app.security)

(defparameter *allowed-extensions* '("wav" "flac" "ogg" "opus" "mp3"))

(defun allowed-audio-extension-p (path)
  (declare (type string path))
  (let ((dot (position #\. path :from-end t)))
    (and dot
         (member (string-downcase (subseq path (1+ dot))) *allowed-extensions* :test #'string=))))

(defun safe-media-path-p (path)
  (declare (type string path))
  (and (> (length path) 0)
       (not (search ".." path :test #'char=))
       (not (search "//" path :test #'char=))
       (or (search "/tmp/" path :test #'char=)
           (search "/var/voice-notes/" path :test #'char=))
       (allowed-audio-extension-p path)))
