(load "packages/clpkg-serial-console-client/src/package.lisp")
(load "packages/clpkg-serial-console-client/src/model.lisp")
(in-package #:clpkg-serial-console-client)

(defun %write-json (path json)
  (ensure-directories-exist path)
  (with-open-file (o path :direction :output :if-exists :supersede)
    (write-string json o)))
(defun %json-bool (x) (if x "true" "false"))

(let* ((sec-path "packages/clpkg-serial-console-client/artifacts/gates/security-gates.json")
       (perf-path "packages/clpkg-serial-console-client/artifacts/gates/perf-gates.json")
       (rel-path "packages/clpkg-serial-console-client/artifacts/gates/release-checks.json")
       (start (get-internal-real-time))
       (summary (build-serial-session-summary
                 (make-serial-session
                  :session-id "sess-1"
                  :state :open
                  :port (make-serial-port-profile :device-path "/dev/ttyUSB0" :baud-rate 115200 :parity :none :flow-control :none))))
       (elapsed-ms (* 1000.0d0 (/ (- (get-internal-real-time) start) internal-time-units-per-second)))
       (sec-ok (and (stringp (getf summary :device)) (member (getf summary :state) '(:new :opening :open :closing :closed :error))))
       (perf-ok (< elapsed-ms 80.0d0))
       (release-ok (and (probe-file "packages/clpkg-serial-console-client/clpkg-serial-console-client.asd")
                        (probe-file "packages/clpkg-serial-console-client/e2e/run-s1-s6.sh"))))
  (%write-json sec-path (format nil "{\"typed_summary\":~A,\"pass\":~A}" (%json-bool sec-ok) (%json-bool sec-ok)))
  (%write-json perf-path (format nil "{\"elapsed_ms\":~,3f,\"budget_ms\":80.0,\"pass\":~A}" elapsed-ms (%json-bool perf-ok)))
  (%write-json rel-path (format nil "{\"asd_present\":~A,\"e2e_script_present\":~A,\"pass\":~A}"
                                (%json-bool (not (null (probe-file "packages/clpkg-serial-console-client/clpkg-serial-console-client.asd"))))
                                (%json-bool (not (null (probe-file "packages/clpkg-serial-console-client/e2e/run-s1-s6.sh"))))
                                (%json-bool release-ok)))
  (unless (and sec-ok perf-ok release-ok)
    (error "serial-client security/perf/release gate failed"))
  (format t "PASS serial-client security/performance/release checks~%"))
