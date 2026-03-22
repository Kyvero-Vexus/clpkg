(asdf:defsystem "clpkg-clipboard-history"
  :description "Typed clipboard history bounded-retention MVP"
  :version "0.1.0"
  :license "MIT"
  :serial t
  :components
  ((:file "src/package")
   (:file "src/model")
   (:file "src/store")))
