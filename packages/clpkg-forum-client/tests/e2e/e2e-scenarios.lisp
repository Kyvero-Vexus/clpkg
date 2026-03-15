(defun slurp (p) (with-open-file (in p) (let ((s (make-string (file-length in)))) (read-sequence s in) s)))
(defun chk (p ns) (let ((c (slurp p))) (dolist (n ns) (unless (search n c :test #'char=) (error "Missing ~S" n)) (format t "  PASS: ~S~%" n))))
(chk "/home/slime/projects/clpkg-forum-client/src/core/forum-types.coal" '("module Core.ForumTypes" "data ForumPlatform" "data ThreadStatus" "data ForumThread" "data ForumPost" "data UserRole" "data ForumUser" "data Category" "data Moderation" "data ModerationAction" "data NotificationType" "data Notification" "data SearchScope" "data ForumBookmark" "data ForumResult" "thread-open-p" "post-is-op" "user-can-moderate" "unread-notification-count"))
(format t "=== ALL PASSED ===~%") (sb-ext:exit :code 0)
