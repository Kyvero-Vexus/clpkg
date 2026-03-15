;;; verify-backup-surface.lisp
(defun slurp (p) (with-open-file (in p) (let ((s (make-string (file-length in)))) (read-sequence s in) s)))
(defun chk (p ns) (unless (probe-file p) (error "Missing: ~A" p))
  (let ((c (slurp p))) (dolist (n ns) (unless (search n c :test #'char=) (error "Missing ~S in ~A" n p)) (format t "  PASS: ~S~%" n))))

(format t "=== Backup/Restore ADTs ===~%")
(chk "/home/slime/projects/clpkg-backup-restore/src/core/backup-types.coal"
     '("module Core.BackupTypes"
       "data BackupType" "data CompressionAlg" "data StorageTargetType" "data StorageTarget"
       "data Snapshot" "data SnapshotStatus" "data RestorePoint" "data RestoreStatus"
       "data RetentionPolicy" "data BackupSchedule" "data ScheduleFreq"
       "data BackupJob" "data JobStatus" "data BackupResult"
       "snapshot-size-human" "retention-expired-p" "job-succeeded-p" "restore-complete-p"))
(format t "=== ALL 18 CHECKS PASSED ===~%")
(sb-ext:exit :code 0)
