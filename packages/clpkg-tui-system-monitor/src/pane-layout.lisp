(in-package #:clpkg-tui-system-monitor)

(declaim (optimize (speed 2) (safety 3) (debug 0) (compilation-speed 0)))

(defstruct (pane-spec (:conc-name pane-))
  (id "" :type string)
  (row 0 :type fixnum)
  (column 0 :type fixnum)
  (width 1 :type fixnum)
  (height 1 :type fixnum)
  (weight 0 :type fixnum))

(declaim (ftype (function (pane-spec pane-spec) boolean) pane<)
         (ftype (function (list) list) deterministic-pane-order))

(defun pane< (left right)
  (declare (type pane-spec left right))
  (or (< (pane-row left) (pane-row right))
      (and (= (pane-row left) (pane-row right))
           (or (< (pane-column left) (pane-column right))
               (and (= (pane-column left) (pane-column right))
                    (or (< (pane-weight left) (pane-weight right))
                        (and (= (pane-weight left) (pane-weight right))
                             (string< (pane-id left) (pane-id right)))))))))

(defun deterministic-pane-order (panes)
  (declare (type list panes))
  (sort (copy-list panes) #'pane<))
