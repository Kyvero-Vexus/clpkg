;;; verify-cluster-surface.lisp
(defun slurp (p) (with-open-file (in p) (let ((s (make-string (file-length in)))) (read-sequence s in) s)))
(defun chk (p ns) (unless (probe-file p) (error "Missing: ~A" p))
  (let ((c (slurp p))) (dolist (n ns) (unless (search n c :test #'char=) (error "Missing ~S in ~A" n p)) (format t "  PASS: ~S~%" n))))

(format t "=== Cluster Orchestrator ADTs ===~%")
(chk "/home/slime/projects/clpkg-cluster-orchestrator/src/core/cluster-types.coal"
     '("module Core.ClusterTypes"
       "data NodeStatus" "data Node" "data PodPhase" "data ContainerStatus"
       "data PodContainer" "data Pod" "data DeploymentStrategy" "data Deployment"
       "data ServiceType" "data Service" "data ScalingMetric" "data ScalingPolicy"
       "data ResourceQuota" "data SchedulerConfig" "data ClusterResult"
       "node-ready-p" "pod-running-p" "deployment-available-p" "scaling-needed-p"))
(format t "=== ALL 19 CHECKS PASSED ===~%")
(sb-ext:exit :code 0)
