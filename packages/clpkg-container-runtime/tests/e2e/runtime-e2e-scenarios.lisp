;;; runtime-e2e-scenarios.lisp — E2E scenario tests for container runtime ADTs
;;; Verifies type surface, constructor totality, and function contracts.

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

(let ((c (slurp "/home/slime/projects/clpkg-container-runtime/src/core/runtime-types.coal")))

  ;; S1: Module declaration
  (assert-contains c "module Core.RuntimeTypes" "S1-module-declaration")

  ;; S2-S15: All 14 ADTs present
  (assert-contains c "data ContainerState" "S2-container-state-adt")
  (assert-contains c "data ImageRef" "S3-image-ref-adt")
  (assert-contains c "data ImagePullPolicy" "S4-image-pull-policy-adt")
  (assert-contains c "data Namespace" "S5-namespace-adt")
  (assert-contains c "data CgroupVersion" "S6-cgroup-version-adt")
  (assert-contains c "data CgroupConfig" "S7-cgroup-config-adt")
  (assert-contains c "data NetworkMode" "S8-network-mode-adt")
  (assert-contains c "data PortMapping" "S9-port-mapping-adt")
  (assert-contains c "data VolumeType" "S10-volume-type-adt")
  (assert-contains c "data VolumeMount" "S11-volume-mount-adt")
  (assert-contains c "data ContainerSpec" "S12-container-spec-adt")
  (assert-contains c "data ContainerInfo" "S13-container-info-adt")
  (assert-contains c "data RuntimeConfig" "S14-runtime-config-adt")
  (assert-contains c "data RuntimeResult" "S15-runtime-result-adt")

  ;; S16-S19: All 4 functions
  (assert-contains c "container-running-p" "S16-container-running-p")
  (assert-contains c "image-tag" "S17-image-tag")
  (assert-contains c "cgroup-memory-limit-bytes" "S18-cgroup-memory-limit-bytes")
  (assert-contains c "volume-readonly-p" "S19-volume-readonly-p")

  ;; S20-S26: Constructor totality (key constructors present)
  (assert-contains c "StateCreated" "S20-state-created-constructor")
  (assert-contains c "StateRunning" "S21-state-running-constructor")
  (assert-contains c "StateStopped" "S22-state-stopped-constructor")
  (assert-contains c "StateDead" "S23-state-dead-constructor")
  (assert-contains c "BridgeNetwork" "S24-bridge-network-constructor")
  (assert-contains c "HostNetwork" "S25-host-network-constructor")
  (assert-contains c "BindMount" "S26-bind-mount-constructor")

  ;; S27-S30: Type signature contracts
  (assert-contains c "ContainerState -> Bool" "S27-running-p-signature")
  (assert-contains c "ImageRef -> String" "S28-image-tag-signature")
  (assert-contains c "CgroupConfig -> Int" "S29-cgroup-mem-signature")
  (assert-contains c "VolumeMount -> Bool" "S30-readonly-p-signature")
)

(format t "~%=== E2E Results: ~D/~D PASSED ===~%" *pass-count* (+ *pass-count* *fail-count*))
(sb-ext:exit :code (if (zerop *fail-count*) 0 1))
