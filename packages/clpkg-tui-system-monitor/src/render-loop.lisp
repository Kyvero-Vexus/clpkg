(in-package #:clpkg-tui-system-monitor)

(declaim (optimize (speed 2) (safety 3) (debug 0) (compilation-speed 0)))

(defstruct (render-frame (:conc-name rframe-))
  (tick 0 :type fixnum)
  (pane-order nil :type list)
  (alerts nil :type list)
  (lines nil :type list))

(declaim (ftype (function (pane-spec) string) render-pane-line)
         (ftype (function (fixnum list list) render-frame) build-render-frame)
         (ftype (function (fixnum list function) list) render-loop))

(defun render-pane-line (pane)
  (declare (type pane-spec pane))
  (format nil "~A@(~D,~D) ~Dx~D"
          (pane-id pane)
          (pane-row pane)
          (pane-column pane)
          (pane-width pane)
          (pane-height pane)))

(defun build-render-frame (tick panes alerts)
  (declare (type fixnum tick)
           (type list panes alerts))
  (let* ((ordered-panes (deterministic-pane-order panes))
         (lines (mapcar #'render-pane-line ordered-panes)))
    (make-render-frame :tick tick
                       :pane-order (mapcar #'pane-id ordered-panes)
                       :alerts alerts
                       :lines lines)))

(defun render-loop (iterations panes frame-producer)
  (declare (type fixnum iterations)
           (type list panes)
           (type function frame-producer))
  (loop for tick fixnum from 0 below iterations
        for sample = (funcall frame-producer tick)
        collect (build-render-frame tick panes sample)))
