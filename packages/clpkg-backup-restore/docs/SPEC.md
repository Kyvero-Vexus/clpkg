# clpkg-backup-restore — Specification

## Overview

Coalton-first typed domain model for backup and restore operations within CL-EMACS.
Provides ADTs for backup jobs, snapshots, restore points, retention policies,
storage targets, and scheduling.

## Module: `Core.BackupTypes`

### ADTs (14 total)

| Type | Purpose | Constructors |
|------|---------|-------------|
| `BackupType` | Backup strategy | Full, Incremental, Differential, Snapshot |
| `CompressionAlg` | Compression | None, Gzip, Zstd, Lz4 |
| `StorageTargetType` | Storage backend | LocalDisk, S3Compatible, Sftp, Nfs |
| `StorageTarget` | Target config | name, type, path, encrypted |
| `SnapshotStatus` | Snapshot lifecycle | Pending, InProgress, Complete, Failed, Expired |
| `Snapshot` | Point-in-time backup | id, type, status, timestamp, size, compression, checksum |
| `RestoreStatus` | Restore lifecycle | Pending, InProgress (%), Complete, Failed, Verifying |
| `RestorePoint` | Restore operation | snapshotId, targetPath, status, timestamp, notes |
| `RetentionPolicy` | Retention rules | keepDaily, keepWeekly, keepMonthly, keepYearly |
| `ScheduleFreq` | Schedule frequency | Hourly, Daily, Weekly, Monthly |
| `BackupSchedule` | Scheduled backup | name, frequency, type, target, retention, enabled |
| `JobStatus` | Job lifecycle | Queued, Running, Succeeded, Failed, Cancelled |
| `BackupJob` | Job instance | id, scheduleName, type, status, target |
| `BackupResult` | Total result | Ok a \| Err String |

### Functions (4 total)

| Function | Signature | Purpose |
|----------|-----------|---------|
| `snapshot-size-human` | `Snapshot → String` | Human-readable size (GiB/MiB/KiB) |
| `retention-expired-p` | `Int → Int → RetentionPolicy → Bool` | Check retention expiry |
| `job-succeeded-p` | `BackupJob → Bool` | Check job success |
| `restore-complete-p` | `RestorePoint → Bool` | Check restore completion |

## Security Considerations

- **Encrypted storage**: `StorageTarget.encrypted` flag enforces at-rest encryption.
- **Checksum verification**: `Snapshot.checksum` enables integrity validation on restore.
- **Retention enforcement**: Automated expiry prevents unbounded storage growth.
- **Credential isolation**: Storage target credentials are external (path-based, not inline).

## Performance Budget

| Operation | Target |
|-----------|--------|
| ADT construction | < 1μs |
| Size formatting | < 1μs (integer division) |
| Retention check | < 100ns |
| Surface verification | < 2s |

## Future Work

- Deduplication block types
- Cross-region replication
- Backup verification/test-restore types
- Bandwidth throttle configuration
