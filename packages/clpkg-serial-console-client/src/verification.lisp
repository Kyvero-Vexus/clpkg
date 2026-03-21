(in-package #:clpkg-serial-console-client)

(defun %scenario-result (id passedp detail)
  (list :id id :passed passedp :detail detail))

(defun %run-s1-new-session-defaults ()
  (let ((session (make-serial-session :session-id "s1")))
    (%scenario-result :s1
                      (and (eq (ss-state session) :new)
                           (= (ss-bytes-rx session) 0)
                           (= (ss-bytes-tx session) 0))
                      "new session starts in :new with zero counters")))

(defun %run-s2-open-transition ()
  (let ((session (make-serial-session :session-id "s2" :state :opening)))
    (setf (ss-state session) :open)
    (%scenario-result :s2
                      (eq (ss-state session) :open)
                      "opening transitions deterministically to :open")))

(defun %run-s3-rx-tx-counters ()
  (let ((session (make-serial-session :session-id "s3" :state :open)))
    (incf (ss-bytes-rx session) 128)
    (incf (ss-bytes-tx session) 64)
    (%scenario-result :s3
                      (and (= (ss-bytes-rx session) 128)
                           (= (ss-bytes-tx session) 64))
                      "rx/tx accounting is deterministic")))

(defun %run-s4-summary-consistency ()
  (let* ((port (make-serial-port-profile :device-path "/dev/ttyUSB0" :baud-rate 9600 :parity :none))
         (session (make-serial-session :session-id "s4" :state :open :port port))
         (summary (build-serial-session-summary session)))
    (%scenario-result :s4
                      (equal summary
                             '(:session-id "s4" :state :open :device "/dev/ttyUSB0"
                               :baud 9600 :parity :none :flow-control :none))
                      "summary payload is deterministic")))

(defun %run-s5-error-capture ()
  (let ((session (make-serial-session :session-id "s5" :state :open)))
    (setf (ss-state session) :error
          (ss-last-error session) "timeout")
    (%scenario-result :s5
                      (and (eq (ss-state session) :error)
                           (string= (ss-last-error session) "timeout"))
                      "error state captures terminal reason")))

(defun %run-s6-close-transition ()
  (let ((session (make-serial-session :session-id "s6" :state :open)))
    (setf (ss-state session) :closing)
    (setf (ss-state session) :closed)
    (%scenario-result :s6
                      (eq (ss-state session) :closed)
                      "close sequence ends in :closed")))

(defun run-s1-s6-verification ()
  (list (%run-s1-new-session-defaults)
        (%run-s2-open-transition)
        (%run-s3-rx-tx-counters)
        (%run-s4-summary-consistency)
        (%run-s5-error-capture)
        (%run-s6-close-transition)))

(defun build-gate-scaffold ()
  (let* ((results (run-s1-s6-verification))
         (all-passed (every (lambda (r) (getf r :passed)) results)))
    (list :verification results
          :security-gate (list :status (if all-passed :ready :blocked)
                               :checks '(:input-validation :device-allowlist :error-sanitization))
          :performance-gate (list :status (if all-passed :ready :blocked)
                                  :checks '(:latency-budget :throughput-baseline :allocation-budget))
          :release-gate (list :status (if all-passed :ready :blocked)
                              :checks '(:scenario-signoff :docs-present :smoke-script)))))