(in-package #:clpkg-shell)

(defun %trim-trailing-newline (s)
  (declare (type string s) (optimize (safety 3)))
  (if (and (> (length s) 0)
           (char= (char s (1- (length s))) #\Newline))
      (subseq s 0 (1- (length s)))
      s))

(defun spawn-shell-session (&key (cwd ".") (shell "/bin/bash") (env-keys '()))
  (declare (type string cwd shell)
           (type list env-keys)
           (optimize (safety 3)))
  (make-shell-session :session-id (format nil "shell-~D" (get-universal-time))
                      :state :running
                      :cwd cwd
                      :shell shell
                      :env-keys env-keys))

(defun run-shell-command (session command)
  (declare (type shell-session session)
           (type string command)
           (optimize (safety 3)))
  (let* ((start (get-internal-real-time))
         (out-stream (make-string-output-stream))
         (err-stream (make-string-output-stream))
         (proc (sb-ext:run-program (ss-shell session)
                                   (list "-lc" command)
                                   :search t
                                   :output out-stream
                                   :error err-stream
                                   :wait t))
         (elapsed (* 1000.0d0 (/ (- (get-internal-real-time) start)
                                 internal-time-units-per-second)))
         (code (sb-ext:process-exit-code proc))
         (out (%trim-trailing-newline (get-output-stream-string out-stream)))
         (err (%trim-trailing-newline (get-output-stream-string err-stream))))
    (make-command-result
     :command command
     :exit-code code
     :stdout out
     :stderr err
     :elapsed-ms elapsed
     :pass-p (= code 0))))
