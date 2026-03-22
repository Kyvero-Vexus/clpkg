(in-package #:clpkg-terminal-multiplexer)

(deftype session-state () '(member :new :active :detached :closed :error))

(defstruct (mux-pane (:conc-name mp-))
  (pane-id "" :type string)
  (index 0 :type integer)
  (command "" :type string)
  (cwd "." :type string))

(defstruct (mux-window (:conc-name mw-))
  (window-id "" :type string)
  (index 0 :type integer)
  (panes '() :type list))

(defstruct (mux-session (:conc-name ms-))
  (session-id "" :type string)
  (state :new :type session-state)
  (windows '() :type list)
  (focused-window-id "" :type string)
  (focused-pane-id "" :type string))

(defstruct (mux-command (:conc-name mc-))
  (target-window-id "" :type string)
  (target-pane-id "" :type string)
  (key "" :type string))

(defun pane-order-deterministic (panes)
  (declare (type list panes) (optimize (safety 3)))
  (sort (copy-list panes)
        (lambda (a b)
          (declare (type mux-pane a b))
          (< (mp-index a) (mp-index b)))))

(defun window-order-deterministic (windows)
  (declare (type list windows) (optimize (safety 3)))
  (sort (copy-list windows)
        (lambda (a b)
          (declare (type mux-window a b))
          (< (mw-index a) (mw-index b)))))

(defun resolve-focused-window (session)
  (declare (type mux-session session) (optimize (safety 3)))
  (or (find (ms-focused-window-id session)
            (ms-windows session)
            :key #'mw-window-id
            :test #'string=)
      (first (window-order-deterministic (ms-windows session)))))

(defun resolve-focused-pane (window session)
  (declare (type mux-window window)
           (type mux-session session)
           (optimize (safety 3)))
  (or (find (ms-focused-pane-id session)
            (mw-panes window)
            :key #'mp-pane-id
            :test #'string=)
      (first (pane-order-deterministic (mw-panes window)))))

(defun route-focus (session)
  (declare (type mux-session session) (optimize (safety 3)))
  (let ((window (resolve-focused-window session)))
    (when window
      (let ((pane (resolve-focused-pane window session)))
        (when pane
          (values (mw-window-id window) (mp-pane-id pane)))))))

(defun dispatch-key (session key)
  (declare (type mux-session session)
           (type string key)
           (optimize (safety 3)))
  (multiple-value-bind (window-id pane-id) (route-focus session)
    (unless (and window-id pane-id)
      (error "Cannot dispatch key without resolvable focus"))
    (make-mux-command :target-window-id window-id
                      :target-pane-id pane-id
                      :key key)))
