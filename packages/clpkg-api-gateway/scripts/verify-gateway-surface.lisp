;;; verify-gateway-surface.lisp

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

(format t "=== API Gateway ADTs Surface Check ===~%")
(check-file "/home/slime/projects/clpkg-api-gateway/src/core/gateway-types.coal"
            '("module Core.GatewayTypes"
              "data HttpMethod" "data Route" "data RouteMatch"
              "data RateLimitWindow" "data RateLimiter"
              "data AuthType" "data AuthPolicy"
              "data TransformOp" "data RequestTransform" "data ResponseTransform"
              "data UpstreamTarget" "data Upstream"
              "data CorsConfig" "data GatewayConfig" "data GatewayResult"
              "route-matches-method" "rate-limit-exceeded-p"
              "auth-required-p" "upstream-healthy-count"))

(format t "=== ALL 19 CHECKS PASSED ===~%")
(sb-ext:exit :code 0)
