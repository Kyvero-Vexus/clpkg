(defun slurp (p) (with-open-file (in p) (let ((s (make-string (file-length in)))) (read-sequence s in) s)))
(defun chk (p ns) (let ((c (slurp p))) (dolist (n ns) (unless (search n c :test #'char=) (error "Missing ~S" n)) (format t "  PASS: ~S~%" n))))
(chk "/home/slime/projects/clpkg-irc-client/src/core/irc-types.coal" '("module Core.IrcTypes" "data IrcMessage" "data IrcCommand" "data IrcChannel" "data ChannelMode" "data UserMode" "data IrcUser" "data CtcpMessage" "data ServerInfo" "data CapabilityState" "data SaslMethod" "data ConnectionConfig" "data NickServAuth" "data BounceConfig" "data IrcResult" "channel-is-moderated" "user-is-op" "capability-negotiated-p" "message-is-privmsg"))
(format t "=== ALL PASSED ===~%") (sb-ext:exit :code 0)
