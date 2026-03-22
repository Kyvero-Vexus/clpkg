(in-package #:clpkg-terminal-emulator)

(defun %make-cells (rows cols)
  (declare (type (integer 1 1000) rows cols))
  (make-array (* rows cols)
              :element-type 'terminal-cell
              :initial-contents
              (loop repeat (* rows cols)
                    collect (make-terminal-cell))))

(defun make-terminal-screen (&key (rows 24) (cols 80))
  (declare (type (integer 1 1000) rows cols))
  (make-terminal-screen-struct
   :rows rows
   :cols cols
   :cells (%make-cells rows cols)
   :cursor-row 0
   :cursor-col 0))

(defun screen-cell-index (screen row col)
  (declare (type terminal-screen screen)
           (type integer row col)
           (optimize (safety 3)))
  (+ (* row (ts-cols screen)) col))

(defun screen-write-char (screen char &key (fg 7) (bg 0) (bold nil))
  "Write CHAR at the cursor position and advance cursor. Returns new screen (functional)."
  (declare (type terminal-screen screen)
           (type character char)
           (optimize (safety 3)))
  (let* ((row (ts-cursor-row screen))
         (col (ts-cursor-col screen))
         (rows (ts-rows screen))
         (cols (ts-cols screen)))
    (when (and (< row rows) (< col cols))
      (let ((idx (screen-cell-index screen row col))
            (new-cells (copy-seq (ts-cells screen))))
        (setf (aref new-cells idx)
              (make-terminal-cell :char char :fg fg :bg bg :bold bold))
        (let ((new-col (1+ col))
              (new-row row))
          (when (>= new-col cols)
            (setf new-col 0)
            (setf new-row (min (1+ row) (1- rows))))
          (make-terminal-screen-struct
           :rows rows :cols cols :cells new-cells
           :cursor-row new-row :cursor-col new-col))))))

(defun screen->lines (screen)
  "Return list of strings, one per row."
  (declare (type terminal-screen screen)
           (optimize (safety 3)))
  (let ((rows (ts-rows screen))
        (cols (ts-cols screen))
        (cells (ts-cells screen)))
    (loop for r from 0 below rows
          collect (with-output-to-string (s)
                    (loop for c from 0 below cols
                          do (write-char (tc-char (aref cells (+ (* r cols) c))) s))))))
