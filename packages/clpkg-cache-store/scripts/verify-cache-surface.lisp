;;; verify-cache-surface.lisp
(defun slurp (p) (with-open-file (in p) (let ((s (make-string (file-length in)))) (read-sequence s in) s)))
(defun chk (p ns) (unless (probe-file p) (error "Missing: ~A" p))
  (let ((c (slurp p))) (dolist (n ns) (unless (search n c :test #'char=) (error "Missing ~S in ~A" n p)) (format t "  PASS: ~S~%" n))))
(format t "=== Cache Store ADTs ===~%")
(chk "/home/slime/projects/clpkg-cache-store/src/core/cache-types.coal"
     '("module Core.CacheTypes"
       "data EvictionPolicy" "data CacheEntry" "data CacheStats"
       "data CacheConfig" "data CacheOperation" "data CacheEvent"
       "data TtlPolicy" "data PartitionStrategy" "data CachePartition"
       "data SerializationFormat" "data WarmupSource" "data CacheHealth"
       "data CacheResult"
       "entry-expired-p" "hit-rate-pct" "cache-full-p" "partition-load-pct"))
(format t "=== ALL 17 CHECKS PASSED ===~%")
(sb-ext:exit :code 0)
