;;;; clpkg-voice-notes-app pipeline stubs
(declaim (optimize (speed 2) (safety 3) (debug 3)))

(defpackage #:clpkg-voice-notes-app.pipeline
  (:use #:cl)
  (:export #:ingest-note
           #:transcribe-note
           #:validate-note
           #:index-note
           #:emit-note))

(in-package #:clpkg-voice-notes-app.pipeline)

(deftype pipeline-result () '(cons keyword t))

(defun %ok (payload)
  (declare (type t payload))
  (the pipeline-result (cons :ok payload)))

(defun ingest-note (source)
  (declare (type string source))
  (%ok (list :stage :ingest :source source)))

(defun transcribe-note (draft)
  (declare (type list draft))
  (%ok (list :stage :transcribe :draft draft)))

(defun validate-note (transcript)
  (declare (type list transcript))
  (%ok (list :stage :validate :transcript transcript :pii-redacted t)))

(defun index-note (validated)
  (declare (type list validated))
  (%ok (list :stage :index :validated validated :index-version "v0")))

(defun emit-note (indexed)
  (declare (type list indexed))
  (%ok (list :stage :emit :indexed indexed :artifact-path "var/voice-notes/example.note")))
