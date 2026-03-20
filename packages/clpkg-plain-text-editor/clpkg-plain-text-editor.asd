(asdf:defsystem "clpkg-plain-text-editor"
  :description "Core scaffold/APIs for plain text editor package"
  :version "0.1.0"
  :serial t
  :components ((:file "src/package")
               (:file "src/types")
               (:file "src/open")
               (:file "src/buffer")
               (:file "src/edit")
               (:file "src/search")
               (:file "src/validate")
               (:file "src/report")))
