(in-package #:clpkg-terminal-emulator)

(defstruct (terminal-cell (:conc-name tc-))
  "A single character cell in a terminal screen."
  (char #\Space :type character)
  (fg    7      :type (integer 0 255))
  (bg    0      :type (integer 0 255))
  (bold  nil    :type boolean))

(defstruct (terminal-screen (:conc-name ts-)
                             (:constructor make-terminal-screen-struct))
  "A fixed-size terminal screen buffer."
  (rows       24     :type (integer 1 1000))
  (cols       80     :type (integer 1 1000))
  (cells      nil    :type (or null (vector terminal-cell)))
  (cursor-row 0      :type integer)
  (cursor-col 0      :type integer))
