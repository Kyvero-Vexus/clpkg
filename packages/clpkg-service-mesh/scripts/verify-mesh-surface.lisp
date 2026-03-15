;;; verify-mesh-surface.lisp

(defun slurp (path)
  (with-open-file (in path :direction :input)
    (let ((s (make-string (file-length in))))
      (read-sequence s in) s)))

(defun must-contain (content needle path)
  (unless (search needle content :test #'char=)
    (error "Missing ~S in ~A" needle path))
  (format t "  PASS: ~S~%" needle))

(defun check-file (path needles)
  (unless (probe-file path) (error "Missing: ~A" path))
  (let ((c (slurp path))) (dolist (n needles) (must-contain c n path))))

(format t "=== Service Mesh ADTs Surface Check ===~%")
(check-file "/home/slime/projects/clpkg-service-mesh/src/core/mesh-types.coal"
            '("module Core.MeshTypes"
              "data Protocol" "data ServiceEndpoint" "data HealthCheckPolicy"
              "data HealthCheckType" "data LoadBalancerPolicy"
              "data CircuitBreakerState" "data CircuitBreakerConfig"
              "data RetryPolicy" "data RetryBackoff" "data MtlsConfig"
              "data MtlsMode" "data ProxyConfig" "data ProxySidecar"
              "data TrafficPolicy" "data MeshResult"
              "endpoint-healthy-p" "circuit-open-p" "max-retries" "mtls-enabled-p"))

(format t "=== ALL 19 CHECKS PASSED ===~%")
(sb-ext:exit :code 0)
