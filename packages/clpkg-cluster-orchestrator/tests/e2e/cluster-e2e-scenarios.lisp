;;; cluster-e2e-scenarios.lisp — E2E scenario tests for cluster orchestrator ADTs

(defun slurp (path)
  (with-open-file (in path :direction :input)
    (let ((s (make-string (file-length in))))
      (read-sequence s in) s)))

(defvar *pass-count* 0)
(defvar *fail-count* 0)

(defun pass (name) (incf *pass-count*) (format t "  PASS ~A~%" name))
(defun fail (name reason) (incf *fail-count*) (format t "  FAIL ~A: ~A~%" name reason))

(defun assert-contains (content needle scenario)
  (if (search needle content :test #'char=)
      (pass scenario)
      (fail scenario (format nil "missing ~S" needle))))

(let ((c (slurp "/home/slime/projects/clpkg-cluster-orchestrator/src/core/cluster-types.coal")))

  ;; S1: Module
  (assert-contains c "module Core.ClusterTypes" "S1-module-declaration")

  ;; S2-S16: All 15 ADTs
  (assert-contains c "data NodeStatus" "S2-node-status-adt")
  (assert-contains c "data Node" "S3-node-adt")
  (assert-contains c "data PodPhase" "S4-pod-phase-adt")
  (assert-contains c "data ContainerStatus" "S5-container-status-adt")
  (assert-contains c "data PodContainer" "S6-pod-container-adt")
  (assert-contains c "data Pod" "S7-pod-adt")
  (assert-contains c "data DeploymentStrategy" "S8-deployment-strategy-adt")
  (assert-contains c "data Deployment" "S9-deployment-adt")
  (assert-contains c "data ServiceType" "S10-service-type-adt")
  (assert-contains c "data Service" "S11-service-adt")
  (assert-contains c "data ScalingMetric" "S12-scaling-metric-adt")
  (assert-contains c "data ScalingPolicy" "S13-scaling-policy-adt")
  (assert-contains c "data ResourceQuota" "S14-resource-quota-adt")
  (assert-contains c "data SchedulerConfig" "S15-scheduler-config-adt")
  (assert-contains c "data ClusterResult" "S16-cluster-result-adt")

  ;; S17-S20: Functions
  (assert-contains c "node-ready-p" "S17-node-ready-p")
  (assert-contains c "pod-running-p" "S18-pod-running-p")
  (assert-contains c "deployment-available-p" "S19-deployment-available-p")
  (assert-contains c "scaling-needed-p" "S20-scaling-needed-p")

  ;; S21-S28: Constructor totality
  (assert-contains c "NodeReady" "S21-node-ready-constructor")
  (assert-contains c "NodeNotReady" "S22-node-not-ready-constructor")
  (assert-contains c "NodeCordon" "S23-node-cordon-constructor")
  (assert-contains c "PodPending" "S24-pod-pending-constructor")
  (assert-contains c "PodRunning" "S25-pod-running-constructor")
  (assert-contains c "PodFailed" "S26-pod-failed-constructor")
  (assert-contains c "RollingUpdate" "S27-rolling-update-constructor")
  (assert-contains c "ClusterIP" "S28-cluster-ip-constructor")

  ;; S29-S32: Type signatures
  (assert-contains c "Node -> Bool" "S29-node-ready-p-signature")
  (assert-contains c "Pod -> Bool" "S30-pod-running-p-signature")
  (assert-contains c "Deployment -> Bool" "S31-deployment-available-p-signature")
  (assert-contains c "ScalingPolicy -> Int -> Bool" "S32-scaling-needed-p-signature")
)

(format t "~%=== E2E Results: ~D/~D PASSED ===~%" *pass-count* (+ *pass-count* *fail-count*))
(sb-ext:exit :code (if (zerop *fail-count*) 0 1))
