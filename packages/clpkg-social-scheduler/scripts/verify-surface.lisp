(defun slurp (p) (with-open-file (in p) (let ((s (make-string (file-length in)))) (read-sequence s in) s)))
(defun chk (p ns) (let ((c (slurp p))) (dolist (n ns) (unless (search n c :test #'char=) (error "Missing ~S" n)) (format t "  PASS: ~S~%" n))))
(chk "/home/slime/projects/clpkg-social-scheduler/src/core/social-types.coal" '("module Core.SocialTypes" "data Platform" "data PostStatus" "data MediaType" "data MediaAttachment" "data Post" "data ScheduledPost" "data PostMetrics" "data Account" "data AccountStatus" "data ContentCalendar" "data HashtagGroup" "data PostTemplate" "data PublishResult" "data SocialResult" "post-published-p" "schedule-overdue-p" "engagement-rate" "account-connected-p"))
(format t "=== ALL PASSED ===~%") (sb-ext:exit :code 0)
