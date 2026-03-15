;;; verify-daw-surface.lisp — Surface verification for Coalton DAW ADTs

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

(let ((base "/home/slime/projects/clpkg-daw/src/core/"))
  (format t "=== DAW Session ADTs Surface Check ===~%")

  (format t "~%session.coal:~%")
  (check-file (concatenate 'string base "session.coal")
              '("module Core.Session"
                "data TrackType" "data Track" "data ClipRef" "data FadeCurve"
                "data Clip" "data AutomationPoint" "data AutomationLane"
                "data TimeSignature" "data TempoEntry" "data TempoMap"
                "data Session" "data SessionResult"
                "track-count" "session-duration-bars" "clip-length-samples"))

  (format t "~%mixer.coal:~%")
  (check-file (concatenate 'string base "mixer.coal")
              '("module Core.Mixer"
                "data MixerChannel" "data Send" "data Insert"
                "data PanLaw" "data MeterReading" "data MixerState"
                "data MixerResult"
                "channel-is-muted" "channel-is-soloed" "effective-gain-db"))

  (format t "~%transport.coal:~%")
  (check-file (concatenate 'string base "transport.coal")
              '("module Core.Transport"
                "data TransportMode" "data LoopRegion" "data TransportState"
                "data TransportCommand" "data TransportResult"
                "transport-is-playing" "transport-is-recording"
                "transport-position-bars" "apply-transport-command")))

(format t "~%=== ALL 3 SURFACE CHECKS PASSED (session + mixer + transport) ===~%")
(sb-ext:exit :code 0)
