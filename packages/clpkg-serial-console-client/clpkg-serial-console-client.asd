(asdf:defsystem "clpkg-serial-console-client"
  :description "Typed serial console client core models"
  :version "0.1.0"
  :license "MIT"
  :serial t
  :components
  ((:file "src/package")
   (:file "src/model")
   (:file "src/verification")))
