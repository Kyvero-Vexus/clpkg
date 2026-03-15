;;; verify-format-surface.lisp — Surface verification for Coalton subtitle ADTs

(defun slurp (path)
  (with-open-file (in path :direction :input)
    (let ((s (make-string (file-length in))))
      (read-sequence s in)
      s)))

(defun must-contain (content needle path)
  (unless (search needle content :test #'char=)
    (error "Missing required token ~S in ~A" needle path))
  (format t "  PASS ~A contains ~S~%" path needle))

(defun check-file (path needles)
  (unless (probe-file path)
    (error "Missing required file: ~A" path))
  (let ((c (slurp path)))
    (dolist (n needles)
      (must-contain c n path))))

(let ((base "/home/slime/projects/clpkg-subtitle-editor/src/core/"))
  (format t "=== Subtitle Format ADTs Surface Check ===~%")

  ;; Core formats
  (format t "~%Checking formats.coal...~%")
  (check-file (concatenate 'string base "formats.coal")
              '("module Core.Formats"
                "data Timestamp" "data TimedCue" "data SubtitleFormat"
                "data CueStyle" "data StyleTag"
                "data SrtEntry" "data VttCue" "data VttHeader"
                "data AssStyle" "data AssDialogue" "data AssScript"
                "data ParseResult"
                "timestamp-to-ms" "ms-to-timestamp" "timestamp-valid-p"))

  ;; SRT parser
  (format t "~%Checking srt-parser.coal...~%")
  (check-file (concatenate 'string base "srt-parser.coal")
              '("module Core.SrtParser"
                "parse-srt" "serialize-srt" "srt-entry-count"
                "import Core.Formats"))

  ;; VTT parser
  (format t "~%Checking vtt-parser.coal...~%")
  (check-file (concatenate 'string base "vtt-parser.coal")
              '("module Core.VttParser"
                "parse-vtt" "serialize-vtt" "vtt-cue-count"
                "import Core.Formats"
                "WEBVTT"))

  ;; ASS parser
  (format t "~%Checking ass-parser.coal...~%")
  (check-file (concatenate 'string base "ass-parser.coal")
              '("module Core.AssParser"
                "parse-ass" "serialize-ass" "ass-dialogue-count"
                "import Core.Formats"
                "[Script Info]")))

(format t "~%=== ALL 4 SURFACE CHECKS PASSED (formats + 3 parsers) ===~%")
(sb-ext:exit :code 0)
