;;; verify-tsdb-surface.lisp
(defun slurp (p) (with-open-file (in p) (let ((s (make-string (file-length in)))) (read-sequence s in) s)))
(defun chk (p ns) (unless (probe-file p) (error "Missing: ~A" p))
  (let ((c (slurp p))) (dolist (n ns) (unless (search n c :test #'char=) (error "Missing ~S" n)) (format t "  PASS: ~S~%" n))))
(format t "=== TSDB ADTs ===~%")
(chk "/home/slime/projects/clpkg-tsdb/src/core/tsdb-types.coal"
     '("module Core.TsdbTypes" "data TimeResolution" "data DataPoint" "data TimeSeries"
       "data AggregateFunction" "data AggregateResult" "data RetentionTier"
       "data DownsamplePolicy" "data QueryRange" "data TsQuery"
       "data WriteBuffer" "data CompactionState" "data ShardKey" "data TsdbConfig" "data TsdbResult"
       "datapoint-in-range" "series-point-count" "retention-expired-p" "buffer-full-p"))
(format t "=== ALL 19 CHECKS PASSED ===~%") (sb-ext:exit :code 0)
