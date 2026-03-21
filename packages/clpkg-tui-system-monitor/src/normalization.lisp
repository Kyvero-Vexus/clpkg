(in-package #:clpkg-tui-system-monitor)

(defun key-like-p (x)
  (or (symbolp x) (stringp x) (characterp x)))

(defun normalize-metric-key (key)
  (string-downcase
   (etypecase key
     (symbol (symbol-name key))
     (string key)
     (character (string key)))))

(defun normalize-metric-value (value)
  (typecase value
    (null :null)
    (integer value)
    (float (coerce value 'double-float))
    (string value)
    (symbol (string-downcase (symbol-name value)))
    (t (princ-to-string value))))

(defun alist-like-p (x)
  (and (listp x)
       (every (lambda (item)
                (and (consp item)
                     (key-like-p (car item))))
              x)))

(defun plist-like-p (x)
  (and (listp x)
       (evenp (length x))
       (loop for (k . rest) on x by #'cddr
             always (and (key-like-p k) rest))))

(defun flatten-metric-tree (tree &optional (prefix ""))
  (labels ((join-key (base next)
             (if (string= base "")
                 next
                 (format nil "~A.~A" base next)))
           (walk (node node-prefix)
             (cond
               ((null node) nil)
               ((alist-like-p node)
                (loop for (k . v) in node
                      append (walk v (join-key node-prefix
                                               (normalize-metric-key k)))))
               ((plist-like-p node)
                (loop for (k v) on node by #'cddr
                      append (walk v (join-key node-prefix
                                               (normalize-metric-key k)))))
               (t (list (cons node-prefix (normalize-metric-value node)))))))
    (walk tree prefix)))

(defun normalize-domain-sample (domain sample)
  (sort (flatten-metric-tree sample (normalize-metric-key domain))
        #'string< :key #'car))

(defun normalize-collector-samples (samples)
  (let ((domain-order '(:cpu :mem :proc :net)))
    (loop for domain in domain-order
          for entry = (assoc domain samples)
          append (normalize-domain-sample domain (cdr entry)))))
