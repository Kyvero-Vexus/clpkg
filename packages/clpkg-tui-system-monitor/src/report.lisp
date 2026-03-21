(in-package #:clpkg-tui-system-monitor)

(declaim
 (ftype (function (monitor-snapshot list list) (values string &optional)) monitor-report->json)
 (ftype (function (monitor-snapshot list list string) (values string &optional)) write-monitor-report))

(defun %json-escape-sm (s)
  (declare (type string s))
  (with-output-to-string (out)
    (loop for ch across s do
      (case ch
        (#\\ (write-string "\\\\" out))
        (#\" (write-string "\\\"" out))
        (#\Newline (write-string "\\n" out))
        (t (write-char ch out))))))

(defun %json-string-sm (s)
  (declare (type string s))
  (format nil "\"~A\"" (%json-escape-sm s)))

(defun monitor-report->json (snapshot panes alerts)
  (declare (type monitor-snapshot snapshot)
           (type list panes alerts)
           (optimize (safety 3)))
  (with-output-to-string (s)
    (write-string "{" s)
    (format s "\"timestamp\":~D" (msnap-timestamp snapshot))
    (format s ",\"cpu_percent\":~,2F" (msnap-cpu-percent snapshot))
    (format s ",\"mem_percent\":~,2F" (msnap-mem-percent snapshot))
    (format s ",\"proc_count\":~D" (msnap-proc-count snapshot))
    (write-string ",\"panes\":[" s)
    (loop for p in panes for i from 0 do
      (when (> i 0) (write-char #\, s))
      (write-string (%json-string-sm p) s))
    (write-string "],\"alerts\":[" s)
    (loop for a in alerts for i from 0 do
      (when (> i 0) (write-char #\, s))
      (write-string (%json-string-sm a) s))
    (write-string "]}" s)))

(defun write-monitor-report (snapshot panes alerts output-path)
  (declare (type monitor-snapshot snapshot)
           (type list panes alerts)
           (type string output-path)
           (optimize (safety 3)))
  (let ((json (monitor-report->json snapshot panes alerts)))
    (ensure-directories-exist output-path)
    (with-open-file (o output-path :direction :output :if-exists :supersede)
      (write-string json o))
    output-path))
