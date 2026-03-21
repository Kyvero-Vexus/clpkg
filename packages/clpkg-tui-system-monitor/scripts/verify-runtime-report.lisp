(load "packages/clpkg-tui-system-monitor/src/package.lisp")
(load "packages/clpkg-tui-system-monitor/src/types.lisp")
(load "packages/clpkg-tui-system-monitor/src/pane-layout.lisp")
(load "packages/clpkg-tui-system-monitor/src/alerts.lisp")
(load "packages/clpkg-tui-system-monitor/src/render-loop.lisp")
(load "packages/clpkg-tui-system-monitor/src/report.lisp")
(load "packages/clpkg-tui-system-monitor/src/runtime.lisp")

(in-package #:clpkg-tui-system-monitor)

(let* ((snap (make-monitor-snapshot
              :timestamp 12345
              :cpu-percent 88.5d0
              :mem-percent 45.0d0
              :proc-count 210
              :net-rx-bytes 1000
              :net-tx-bytes 1200))
       (panes (list (make-pane-spec :id "alerts" :weight 3)
                    (make-pane-spec :id "overview" :weight 1)
                    (make-pane-spec :id "processes" :weight 2)))
       (alerts (list (make-threshold-alert :id "cpu" :metric-key "cpu-percent" :threshold 80.0d0)
                     (make-threshold-alert :id "mem" :metric-key "mem-percent" :threshold 90.0d0)))
       (out "packages/clpkg-tui-system-monitor/artifacts/runtime/runtime-report.json")
       (path (run-monitor-runtime snap panes alerts out))
       (json (with-open-file (s path :direction :input)
               (let ((txt (make-string (file-length s))))
                 (read-sequence txt s)
                 txt))))
  (unless (and (search "\"panes\":[\"overview\",\"processes\",\"alerts\"]" json)
               (search "\"alerts\":[\"cpu:triggered\"]" json))
    (error "runtime report determinism check failed: ~A" json))
  (format t "PASS runtime hooks + machine-report determinism checks~%"))
