;;; verify-normalization.lisp
(require :asdf)
(asdf:load-asd #P"/home/slime/projects/clpkg/packages/clpkg-tui-system-monitor/clpkg-tui-system-monitor.asd")
(asdf:load-system :clpkg-tui-system-monitor)

(defun assert-true (condition fmt &rest args)
  (unless condition
    (error (apply #'format nil fmt args))))

(let* ((samples-a
         (list (cons :net '((:tx-bytes . 42) (:rx-bytes . 21)))
               (cons :cpu '((:idle . 98.5f0) (:state . :ok)))
               (cons :proc '(:total 100 :running 12))
               (cons :mem '((:used . 2048) (:unit . :mb)))))
       (samples-b
         (list (cons :cpu '((:state . :ok) (:idle . 98.5d0)))
               (cons :mem '((:unit . :mb) (:used . 2048)))
               (cons :proc '(:running 12 :total 100))
               (cons :net '((:rx-bytes . 21) (:tx-bytes . 42)))))
       (norm-a (clpkg-tui-system-monitor:normalize-collector-samples samples-a))
       (norm-b (clpkg-tui-system-monitor:normalize-collector-samples samples-b))
       (keys (mapcar #'car norm-a)))
  (assert-true (equal norm-a norm-b)
               "Normalization not deterministic across input order.~%A=~S~%B=~S"
               norm-a norm-b)
  (assert-true (equal keys
                      '("cpu.idle" "cpu.state"
                        "mem.unit" "mem.used"
                        "proc.running" "proc.total"
                        "net.rx-bytes" "net.tx-bytes"))
               "Unexpected key order: ~S" keys)
  (assert-true (typep (cdr (assoc "cpu.idle" norm-a :test #'string=)) 'double-float)
               "cpu.idle should normalize to DOUBLE-FLOAT")
  (assert-true (equal (cdr (assoc "cpu.state" norm-a :test #'string=)) "ok")
               "cpu.state should normalize symbol to lowercase string")
  (format t "PASS normalization determinism/key-order checks~%")
  (sb-ext:exit :code 0))
