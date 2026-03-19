(asdf:defsystem #:clpkg-outliner
  :description "Bootstrap outliner core model"
  :version "0.1.0"
  :author "Chrysolambda"
  :license "MIT"
  :serial t
  :components ((:file "src/package")
               (:file "src/model")))
