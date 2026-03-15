;;; verify-runtime-surface.lisp
(defun slurp (p) (with-open-file (in p) (let ((s (make-string (file-length in)))) (read-sequence s in) s)))
(defun chk (p ns) (unless (probe-file p) (error "Missing: ~A" p))
  (let ((c (slurp p))) (dolist (n ns) (unless (search n c :test #'char=) (error "Missing ~S in ~A" n p)) (format t "  PASS: ~S~%" n))))

(format t "=== Container Runtime ADTs ===~%")
(chk "/home/slime/projects/clpkg-container-runtime/src/core/runtime-types.coal"
     '("module Core.RuntimeTypes"
       "data ContainerState" "data ImageRef" "data ImagePullPolicy"
       "data Namespace" "data CgroupVersion" "data CgroupConfig"
       "data NetworkMode" "data PortMapping" "data VolumeType" "data VolumeMount"
       "data ContainerSpec" "data ContainerInfo" "data RuntimeConfig" "data RuntimeResult"
       "container-running-p" "image-tag" "cgroup-memory-limit-bytes" "volume-readonly-p"))
(format t "=== ALL 18 CHECKS PASSED ===~%")
(sb-ext:exit :code 0)
