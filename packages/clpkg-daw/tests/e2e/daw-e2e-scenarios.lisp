;;; daw-e2e-scenarios.lisp — E2E for DAW ADTs

(defun slurp (p) (with-open-file (in p) (let ((s (make-string (file-length in)))) (read-sequence s in) s)))
(defvar *pass* 0) (defvar *fail* 0)
(defun pass (n) (incf *pass*) (format t "  PASS ~A~%" n))
(defun fail (n r) (incf *fail*) (format t "  FAIL ~A: ~A~%" n r))
(defun ac (c needle s) (if (search needle c :test #'char=) (pass s) (fail s (format nil "missing ~S" needle))))

;; Session module
(let ((c (slurp "/home/slime/projects/clpkg-daw/src/core/session.coal")))
  (ac c "module Core.Session" "S1-session-module")
  (ac c "data TrackType" "S2-track-type")
  (ac c "data Track" "S3-track")
  (ac c "data ClipRef" "S4-clip-ref")
  (ac c "data FadeCurve" "S5-fade-curve")
  (ac c "data Clip" "S6-clip")
  (ac c "data AutomationPoint" "S7-automation-point")
  (ac c "data AutomationLane" "S8-automation-lane")
  (ac c "data TimeSignature" "S9-time-signature")
  (ac c "data TempoEntry" "S10-tempo-entry")
  (ac c "data TempoMap" "S11-tempo-map")
  (ac c "data Session" "S12-session")
  (ac c "data SessionResult" "S13-session-result"))

;; Mixer module
(let ((c (slurp "/home/slime/projects/clpkg-daw/src/core/mixer.coal")))
  (ac c "module Core.Mixer" "S14-mixer-module")
  (ac c "data PanLaw" "S15-pan-law")
  (ac c "data Send" "S16-send")
  (ac c "data Insert" "S17-insert")
  (ac c "data MeterReading" "S18-meter-reading")
  (ac c "data MixerChannel" "S19-mixer-channel")
  (ac c "data MixerState" "S20-mixer-state")
  (ac c "data MixerResult" "S21-mixer-result"))

;; Transport module
(let ((c (slurp "/home/slime/projects/clpkg-daw/src/core/transport.coal")))
  (ac c "module Core.Transport" "S22-transport-module")
  (ac c "data TransportMode" "S23-transport-mode")
  (ac c "data LoopRegion" "S24-loop-region")
  (ac c "data TransportState" "S25-transport-state")
  (ac c "data TransportCommand" "S26-transport-command")
  (ac c "transport-is-playing" "S27-is-playing")
  (ac c "transport-is-recording" "S28-is-recording")
  (ac c "transport-position-bars" "S29-position-bars")
  (ac c "apply-transport-command" "S30-apply-command"))

(format t "~%=== E2E Results: ~D/~D PASSED ===~%" *pass* (+ *pass* *fail*))
(sb-ext:exit :code (if (zerop *fail*) 0 1))
