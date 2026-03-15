;;; verify-protocol-surface.lisp — Surface verification for Coalton stream protocol ADTs

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

(let ((base "/home/slime/projects/clpkg-livestream-encoder/src/core/"))
  (format t "=== Stream Protocol ADTs Surface Check ===~%")

  ;; Core protocols
  (format t "~%Checking protocols.coal...~%")
  (check-file (concatenate 'string base "protocols.coal")
              '("module Core.Protocols"
                "data StreamProtocol" "data Bitrate" "data StreamConfig"
                "data RtmpChunkType" "data RtmpChunk" "data RtmpHandshake"
                "data HlsSegment" "data HlsPlaylist" "data HlsPlaylistType"
                "data FlvTag" "data FlvTagType" "data FlvHeader"
                "data FrameResult"
                "bitrate-to-bps" "bitrate-valid-p"))

  ;; RTMP frames
  (format t "~%Checking rtmp-frames.coal...~%")
  (check-file (concatenate 'string base "rtmp-frames.coal")
              '("module Core.RtmpFrames"
                "make-rtmp-chunk" "make-handshake-c0" "make-handshake-c1"
                "rtmp-chunk-header-size" "serialize-rtmp-chunk"
                "import Core.Protocols"))

  ;; HLS segments
  (format t "~%Checking hls-segments.coal...~%")
  (check-file (concatenate 'string base "hls-segments.coal")
              '("module Core.HlsSegments"
                "make-hls-segment" "make-hls-playlist" "hls-segment-count"
                "serialize-hls-playlist"
                "import Core.Protocols"))

  ;; FLV tags
  (format t "~%Checking flv-tags.coal...~%")
  (check-file (concatenate 'string base "flv-tags.coal")
              '("module Core.FlvTags"
                "make-flv-header" "make-flv-tag" "flv-tag-type-id"
                "serialize-flv-header"
                "import Core.Protocols")))

(format t "~%=== ALL 4 SURFACE CHECKS PASSED (protocols + 3 frame types) ===~%")
(sb-ext:exit :code 0)
