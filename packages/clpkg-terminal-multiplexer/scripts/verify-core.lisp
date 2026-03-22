(load "packages/clpkg-terminal-multiplexer/src/package.lisp")
(load "packages/clpkg-terminal-multiplexer/src/model.lisp")
(in-package #:clpkg-terminal-multiplexer)

(let* ((p2 (make-mux-pane :pane-id "p2" :index 2 :command "bash" :cwd "/tmp"))
       (p1 (make-mux-pane :pane-id "p1" :index 1 :command "bash" :cwd "/tmp"))
       (w2 (make-mux-window :window-id "w2" :index 2 :panes (list p2)))
       (w1 (make-mux-window :window-id "w1" :index 1 :panes (list p1)))
       (ordered-panes (pane-order-deterministic (list p2 p1)))
       (ordered-windows (window-order-deterministic (list w2 w1)))
       (session (make-mux-session :session-id "s1"
                                  :state :active
                                  :windows (list w2 w1)
                                  :focused-window-id ""
                                  :focused-pane-id ""))
       (cmd (dispatch-key session "C-b")))
  (unless (and (string= (mp-pane-id (first ordered-panes)) "p1")
               (string= (mw-window-id (first ordered-windows)) "w1"))
    (error "terminal-multiplexer core ordering failed"))
  (unless (and (string= (mc-target-window-id cmd) "w1")
               (string= (mc-target-pane-id cmd) "p1")
               (string= (mc-key cmd) "C-b"))
    (error "terminal-multiplexer focus routing/dispatch failed"))
  (format t "PASS terminal-multiplexer typed core ordering+dispatch~%"))
