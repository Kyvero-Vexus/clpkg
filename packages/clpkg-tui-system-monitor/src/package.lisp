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
   #:make-snapshot-delta
   #:metric-collector
   #:collect-cpu
   #:collect-mem
   #:collect-proc
   #:collect-net
   #:collect-all-domains
   #:normalize-metric-key
   #:normalize-metric-value
   #:flatten-metric-tree
   #:normalize-domain-sample
   #:normalize-collector-samples))
