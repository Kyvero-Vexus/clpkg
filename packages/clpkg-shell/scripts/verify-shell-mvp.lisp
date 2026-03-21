(load "packages/clpkg-shell/src/package.lisp")
(load "packages/clpkg-shell/src/model.lisp")
(load "packages/clpkg-shell/src/api.lisp")

(in-package #:clpkg-shell)

(let* ((sess (spawn-shell-session :cwd "/tmp" :shell "/bin/bash" :env-keys '("PATH" "HOME")))
       (res (run-shell-command sess "printf hello")))
  (unless (and (eq (ss-state sess) :running)
               (cr-pass-p res)
               (string= (cr-stdout res) "hello")
               (= (cr-exit-code res) 0))
    (error "shell MVP verification failed: ~S ~S" (shell-session-summary sess) res))
  (format t "PASS shell mvp process launch + command execution~%"))
