(asdf:defsystem "clpkg-terminal-emulator"
  :description "Typed terminal emulator screen buffer (functional, pure)"
  :version "0.1.0"
  :license "MIT"
  :serial t
  :components
  ((:file "src/package")
   (:file "src/model")
   (:file "src/screen")))
