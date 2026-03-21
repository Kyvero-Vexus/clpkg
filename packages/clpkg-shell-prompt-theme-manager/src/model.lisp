(in-package #:clpkg-shell-prompt-theme-manager)

(defstruct (prompt-theme (:conc-name pt-))
  (name "default" :type string)
  (left-format "[~A]" :type string)
  (right-format "(~A)" :type string)
  (separator " " :type string)
  (accent "green" :type string))

(defstruct (prompt-context (:conc-name pc-))
  (cwd "~" :type string)
  (branch "main" :type string)
  (exit-code 0 :type integer)
  (time-label "00:00" :type string))

(defstruct (rendered-prompt (:conc-name rp-))
  (left "" :type string)
  (right "" :type string)
  (full "" :type string))
