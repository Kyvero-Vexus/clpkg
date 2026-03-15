(defun slurp (p) (with-open-file (in p) (let ((s (make-string (file-length in)))) (read-sequence s in) s)))
(defun chk (p ns) (let ((c (slurp p))) (dolist (n ns) (unless (search n c :test #'char=) (error "Missing ~S" n)) (format t "  PASS: ~S~%" n))))
(chk "/home/slime/projects/clpkg-email-client/src/core/email-types.coal" '("module Core.EmailTypes" "data EmailProtocol" "data EmailAddress" "data EmailHeader" "data EmailBody" "data ContentType" "data Attachment" "data Email" "data Mailbox" "data MailboxType" "data FilterRule" "data FilterAction" "data SmtpConfig" "data ImapConfig" "data EmailResult" "email-has-attachments" "mailbox-unread-count" "filter-matches-sender" "email-is-encrypted"))
(format t "=== ALL PASSED ===~%") (sb-ext:exit :code 0)
