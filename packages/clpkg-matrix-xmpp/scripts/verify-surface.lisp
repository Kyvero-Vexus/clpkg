(defun slurp (p) (with-open-file (in p) (let ((s (make-string (file-length in)))) (read-sequence s in) s)))
(defun chk (p ns) (let ((c (slurp p))) (dolist (n ns) (unless (search n c :test #'char=) (error "Missing ~S" n)) (format t "  PASS: ~S~%" n))))
(chk "/home/slime/projects/clpkg-matrix-xmpp/src/core/federation-types.coal" '("module Core.FederationTypes" "data Protocol" "data ServerId" "data RoomVisibility" "data Room" "data RoomEvent" "data EventType" "data Membership" "data EncryptionState" "data DeviceKey" "data SyncState" "data Presence" "data PowerLevel" "data RoomAlias" "data FederationResult" "room-is-encrypted" "membership-is-join" "sync-has-events" "power-level-admin-p"))
(format t "=== ALL PASSED ===~%") (sb-ext:exit :code 0)
