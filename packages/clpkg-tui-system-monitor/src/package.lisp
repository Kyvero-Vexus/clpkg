(defpackage #:clpkg-tui-system-monitor
  (:use #:cl)
  (:export
   #:monitor-config
   #:monitor-config-p
   #:make-monitor-config
   #:monitor-snapshot
   #:monitor-snapshot-p
   #:make-monitor-snapshot
   #:snapshot-delta
   #:snapshot-delta-p
   #:make-snapshot-delta))
