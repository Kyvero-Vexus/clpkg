(asdf:defsystem "clpkg-shell"
  :description "Typed shell process launch and command execution API"
  :version "0.1.0"
  :license "MIT"
  :serial t
  :components
  ((:file "src/package")
   (:file "src/model")
   (:file "src/api")))
