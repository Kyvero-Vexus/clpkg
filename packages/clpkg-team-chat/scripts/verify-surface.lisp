(defun slurp (p) (with-open-file (in p) (let ((s (make-string (file-length in)))) (read-sequence s in) s)))
(defun chk (p ns) (let ((c (slurp p))) (dolist (n ns) (unless (search n c :test #'char=) (error "Missing ~S" n)) (format t "  PASS: ~S~%" n))))
(chk "/home/slime/projects/clpkg-team-chat/src/core/chat-types.coal" '("module Core.ChatTypes" "data ChannelType" "data Channel" "data Message" "data MessageType" "data Reaction" "data ThreadReply" "data UserPresence" "data PresenceStatus" "data Workspace" "data Integration" "data IntegrationStatus" "data SearchFilter" "data Mention" "data ChatResult" "channel-is-dm" "message-has-thread" "user-online-p" "workspace-channel-count"))
(format t "=== ALL PASSED ===~%") (sb-ext:exit :code 0)
