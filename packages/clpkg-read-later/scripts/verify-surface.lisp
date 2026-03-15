(defun slurp (p) (with-open-file (in p) (let ((s (make-string (file-length in)))) (read-sequence s in) s)))
(defun chk (p ns) (let ((c (slurp p))) (dolist (n ns) (unless (search n c :test #'char=) (error "Missing ~S" n)) (format t "  PASS: ~S~%" n))))
(chk "/home/slime/projects/clpkg-read-later/src/core/reader-types.coal" '("module Core.ReaderTypes" "data ArticleStatus" "data Article" "data ContentFormat" "data ReadingProgress" "data Highlight" "data HighlightColor" "data Annotation" "data Tag" "data ReadingList" "data ArchiveFormat" "data OfflineCache" "data CacheStatus" "data ExportTarget" "data ReaderResult" "article-read-p" "reading-progress-pct" "highlight-count" "cache-available-p"))
(format t "=== ALL PASSED ===~%") (sb-ext:exit :code 0)
