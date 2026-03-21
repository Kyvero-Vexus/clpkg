(in-package #:clpkg-tui-system-monitor)

(declaim (optimize (speed 2) (safety 3) (debug 0) (compilation-speed 0)))

(defstruct (threshold-alert (:conc-name alert-))
  (id "" :type string)
  (metric-key "" :type string)
  (operator :>= :type keyword)
  (threshold 0.0d0 :type double-float)
  (severity :warn :type keyword)
  (message "" :type string))

(defstruct (alert-hit (:conc-name hit-))
  (alert-id "" :type string)
  (metric-key "" :type string)
  (actual-value 0.0d0 :type double-float)
  (threshold 0.0d0 :type double-float)
  (severity :warn :type keyword)
  (message "" :type string))

(declaim (ftype (function (keyword double-float double-float) boolean) compare-threshold)
         (ftype (function (t) double-float) ->double-float)
         (ftype (function (threshold-alert list) (or null alert-hit)) evaluate-threshold-alert)
         (ftype (function (list list) list) evaluate-threshold-alerts))

(defun compare-threshold (operator value threshold)
  (declare (type keyword operator)
           (type double-float value threshold))
  (ecase operator
    (:> (> value threshold))
    (:>= (>= value threshold))
    (:< (< value threshold))
    (:<= (<= value threshold))
    (:== (= value threshold))
    (:/= (/= value threshold))))

(defun ->double-float (value)
  (typecase value
    (double-float value)
    (float (coerce value 'double-float))
    (integer (coerce value 'double-float))
    (t 0.0d0)))

(defun evaluate-threshold-alert (alert normalized-sample)
  (declare (type threshold-alert alert)
           (type list normalized-sample))
  (let* ((pair (assoc (alert-metric-key alert) normalized-sample :test #'string=))
         (actual (->double-float (cdr pair))))
    (when (and pair
               (compare-threshold (alert-operator alert)
                                  actual
                                  (alert-threshold alert)))
      (make-alert-hit :alert-id (alert-id alert)
                      :metric-key (alert-metric-key alert)
                      :actual-value actual
                      :threshold (alert-threshold alert)
                      :severity (alert-severity alert)
                      :message (alert-message alert)))))

(defun evaluate-threshold-alerts (alerts normalized-sample)
  (declare (type list alerts normalized-sample))
  (let ((hits
          (loop for alert in alerts
                for hit = (evaluate-threshold-alert alert normalized-sample)
                when hit collect hit)))
    (sort hits #'string< :key #'hit-alert-id)))
