(in-package #:clpkg-tui-system-monitor)

(defclass metric-collector () ())

(defgeneric collect-cpu (collector)
  (:documentation "Collect raw CPU metrics as an alist/plist/tree."))

(defgeneric collect-mem (collector)
  (:documentation "Collect raw memory metrics as an alist/plist/tree."))

(defgeneric collect-proc (collector)
  (:documentation "Collect raw process metrics as an alist/plist/tree."))

(defgeneric collect-net (collector)
  (:documentation "Collect raw network metrics as an alist/plist/tree."))

(defmethod collect-cpu ((collector t))
  (declare (ignore collector))
  nil)

(defmethod collect-mem ((collector t))
  (declare (ignore collector))
  nil)

(defmethod collect-proc ((collector t))
  (declare (ignore collector))
  nil)

(defmethod collect-net ((collector t))
  (declare (ignore collector))
  nil)

(defun collect-all-domains (collector)
  (list (cons :cpu (collect-cpu collector))
        (cons :mem (collect-mem collector))
        (cons :proc (collect-proc collector))
        (cons :net (collect-net collector))))
