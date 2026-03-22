(load "packages/clpkg-terminal-emulator/src/package.lisp")
(load "packages/clpkg-terminal-emulator/src/model.lisp")
(load "packages/clpkg-terminal-emulator/src/screen.lisp")
(in-package #:clpkg-terminal-emulator)

(let* ((s0 (make-terminal-screen :rows 3 :cols 5))
       ;; write 'H' 'i' into a fresh screen
       (s1 (screen-write-char s0 #\H))
       (s2 (screen-write-char s1 #\i))
       (lines (screen->lines s2)))
  ;; cursor should have advanced to col 2
  (unless (= (ts-cursor-col s2) 2)
    (error "cursor did not advance: got ~D" (ts-cursor-col s2)))
  ;; first line should start with "Hi"
  (unless (and (char= (char (first lines) 0) #\H)
               (char= (char (first lines) 1) #\i))
    (error "screen content wrong: ~S" (first lines)))
  ;; original screen unmodified (functional)
  (unless (char= (tc-char (aref (ts-cells s0) 0)) #\Space)
    (error "original screen was mutated"))
  (format t "PASS terminal-emulator typed screen buffer + functional writes~%"))
