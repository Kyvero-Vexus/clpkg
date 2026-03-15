;;; verify-obs-surface.lisp

(defun slurp (path)
  (with-open-file (in path :direction :input)
    (let ((s (make-string (file-length in))))
      (read-sequence s in)
      s)))

(defun must-contain (content needle path)
  (unless (search needle content :test #'char=)
    (error "Missing ~S in ~A" needle path))
  (format t "  PASS: ~S~%" needle))

(defun check-file (path needles)
  (unless (probe-file path)
    (error "Missing file: ~A" path))
  (let ((c (slurp path)))
    (dolist (n needles) (must-contain c n path))))

(format t "=== Observability ADTs Surface Check ===~%")
(check-file "/home/slime/projects/clpkg-observability/src/core/obs-types.coal"
            '("module Core.ObsTypes"
              "data MetricType" "data MetricUnit" "data Metric" "data MetricPoint"
              "data SpanStatus" "data SpanContext" "data Span"
              "data LogLevel" "data LogEntry"
              "data HealthStatus" "data HealthCheck"
              "data AlertSeverity" "data AlertState" "data AlertRule"
              "data ObsResult"
              "metric-is-counter" "span-duration-ms"
              "log-level-rank" "health-ok-p" "alert-firing-p"))

(format t "=== ALL 20 CHECKS PASSED ===~%")
(sb-ext:exit :code 0)
