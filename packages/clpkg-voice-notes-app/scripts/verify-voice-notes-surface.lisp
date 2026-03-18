(defun slurp (p)
  (with-open-file (in p)
    (let ((s (make-string (file-length in))))
      (read-sequence s in)
      s)))

(defun chk (p needles)
  (let ((c (slurp p)))
    (dolist (n needles)
      (unless (search n c :test #'char=)
        (error "Missing ~S" n))
      (format t "  PASS: ~S~%" n))))

(chk "/home/slime/projects/clpkg/packages/clpkg-voice-notes-app/src/core/voice-notes-types.coal"
     '("module Core.VoiceNotesTypes"
       "data AudioCodec"
       "data VoiceNoteDraft"
       "data VoiceNoteTranscript"
       "data VoiceNoteValidated"
       "data VoiceNoteIndexed"
       "data VoiceNoteArtifact"
       "data PipelineResult"
       "deterministic-note-id"
       "transcript-nonempty-p"))

(chk "/home/slime/projects/clpkg/packages/clpkg-voice-notes-app/src/pipeline/pipeline-stubs.lisp"
     '("(defun ingest-note"
       "(defun transcribe-note"
       "(defun validate-note"
       "(defun index-note"
       "(defun emit-note"))

(format t "=== ALL PASSED ===~%")
(sb-ext:exit :code 0)
