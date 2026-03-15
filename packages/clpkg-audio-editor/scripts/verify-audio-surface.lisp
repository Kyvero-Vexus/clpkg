;;; verify-audio-surface.lisp — Surface verification for Coalton audio ADTs

(defun slurp (path)
  (with-open-file (in path :direction :input)
    (let ((s (make-string (file-length in))))
      (read-sequence s in)
      s)))

(defun must-contain (content needle path)
  (unless (search needle content :test #'char=)
    (error "Missing required token ~S in ~A" needle path))
  (format t "  PASS ~A: ~S~%" (file-namestring path) needle))

(defun check-file (path needles)
  (unless (probe-file path)
    (error "Missing required file: ~A" path))
  (let ((c (slurp path)))
    (dolist (n needles)
      (must-contain c n path))))

(let ((base "/home/slime/projects/clpkg-audio-editor/src/core/"))
  (format t "=== Audio Format ADTs Surface Check ===~%")

  (format t "~%formats.coal:~%")
  (check-file (concatenate 'string base "formats.coal")
              '("module Core.Formats"
                "data AudioFormat" "data SampleRate" "data BitDepth"
                "data ChannelLayout" "data SampleBuffer" "data AudioRegion"
                "data EffectType" "data EffectParam" "data EffectChain"
                "data WavFmtChunk" "data WavDataChunk" "data WavFile"
                "data FlacStreamInfo" "data FlacVorbisComment" "data FlacMetadata"
                "data OggPage" "data Mp3FrameHeader" "data ParseResult"
                "sample-rate-hz" "bit-depth-bits"
                "buffer-duration-ms" "region-length-samples"))

  (format t "~%wav-parser.coal:~%")
  (check-file (concatenate 'string base "wav-parser.coal")
              '("module Core.WavParser"
                "parse-wav-header" "validate-wav-fmt"
                "serialize-wav-header" "wav-duration-ms"
                "import Core.Formats"))

  (format t "~%metadata.coal:~%")
  (check-file (concatenate 'string base "metadata.coal")
              '("module Core.Metadata"
                "parse-flac-streaminfo" "parse-ogg-page"
                "parse-mp3-frame-header" "detect-format"
                "import Core.Formats")))

(format t "~%=== ALL 3 SURFACE CHECKS PASSED (formats + wav + metadata) ===~%")
(sb-ext:exit :code 0)
