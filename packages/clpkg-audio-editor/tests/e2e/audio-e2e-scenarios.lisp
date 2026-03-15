;;; audio-e2e-scenarios.lisp — E2E for audio editor ADTs

(defun slurp (p) (with-open-file (in p) (let ((s (make-string (file-length in)))) (read-sequence s in) s)))
(defvar *pass* 0) (defvar *fail* 0)
(defun pass (n) (incf *pass*) (format t "  PASS ~A~%" n))
(defun fail (n r) (incf *fail*) (format t "  FAIL ~A: ~A~%" n r))
(defun ac (c needle s) (if (search needle c :test #'char=) (pass s) (fail s (format nil "missing ~S" needle))))

;; Formats
(let ((c (slurp "/home/slime/projects/clpkg-audio-editor/src/core/formats.coal")))
  (ac c "module Core.Formats" "S1-formats-module")
  (ac c "data AudioFormat" "S2-audio-format")
  (ac c "data SampleRate" "S3-sample-rate")
  (ac c "data BitDepth" "S4-bit-depth")
  (ac c "data ChannelLayout" "S5-channel-layout")
  (ac c "data SampleBuffer" "S6-sample-buffer")
  (ac c "data AudioRegion" "S7-audio-region")
  (ac c "data EffectType" "S8-effect-type")
  (ac c "data EffectParam" "S9-effect-param")
  (ac c "data EffectChain" "S10-effect-chain")
  (ac c "data WavFmtChunk" "S11-wav-fmt-chunk")
  (ac c "data WavDataChunk" "S12-wav-data-chunk")
  (ac c "data WavFile" "S13-wav-file")
  (ac c "data FlacStreamInfo" "S14-flac-streaminfo")
  (ac c "data FlacVorbisComment" "S15-flac-vorbis")
  (ac c "data FlacMetadata" "S16-flac-metadata")
  (ac c "data OggPage" "S17-ogg-page")
  (ac c "data Mp3FrameHeader" "S18-mp3-frame")
  (ac c "data ParseResult" "S19-parse-result"))

;; WAV parser
(let ((c (slurp "/home/slime/projects/clpkg-audio-editor/src/core/wav-parser.coal")))
  (ac c "module Core.WavParser" "S20-wav-parser-module")
  (ac c "serialize-wav-header" "S21-serialize-wav")
  (ac c "wav-duration-ms" "S22-wav-duration"))

;; Metadata
(let ((c (slurp "/home/slime/projects/clpkg-audio-editor/src/core/metadata.coal")))
  (ac c "module Core.Metadata" "S23-metadata-module")
  (ac c "parse-flac-streaminfo" "S24-parse-flac")
  (ac c "parse-ogg-page" "S25-parse-ogg")
  (ac c "parse-mp3-frame-header" "S26-parse-mp3")
  (ac c "detect-format" "S27-detect-format"))

(format t "~%=== E2E Results: ~D/~D PASSED ===~%" *pass* (+ *pass* *fail*))
(sb-ext:exit :code (if (zerop *fail*) 0 1))
