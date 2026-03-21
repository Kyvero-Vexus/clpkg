(asdf:defsystem "clpkg-tui-system-monitor"
  :description "Typed TUI system monitor scaffold"
  :version "0.1.0"
  :license "MIT"
  :serial t
  :components
  ((:file "src/package")
   (:file "src/types")
   (:file "src/collector-interfaces")
   (:file "src/normalization")))
