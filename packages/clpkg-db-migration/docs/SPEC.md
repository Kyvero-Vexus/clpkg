# clpkg-db-migration — Specification

## Overview

Coalton-first typed domain model for database schema migrations within CL-EMACS.
Provides ADTs for migration steps, schema diffs, version tracking, rollback strategies,
and advisory locking.

## Module: `Core.MigrationTypes` — 14 ADTs + 4 functions

| Type | Purpose |
|------|---------|
| `MigrationDirection` | Up/Down |
| `MigrationStatus` | Pending, Running, Applied, Failed, RolledBack |
| `MigrationStep` | Named versioned migration with up/down SQL |
| `MigrationPlan` | Ordered steps with current→target version |
| `SchemaVersion` | Version + checksum + dirty flag |
| `ColumnChange` | Add/Drop/Alter/Rename column |
| `TableChange` | Create/Drop/Rename/Alter table |
| `IndexChange` | Create/Drop index |
| `SchemaDiff` | Table + index changes with destructive flag |
| `RollbackStrategy` | Auto/Manual/None |
| `MigrationConfig` | Directory, table, rollback, dry-run, lock timeout |
| `MigrationLog` | Audit trail entry |
| `LockStatus` | Advisory lock state |
| `MigrationResult` | Total result type |

## Security
- Advisory locking prevents concurrent migrations
- Destructive change detection (`diff-has-destructive`)
- Dry-run mode in config
- Rollback strategy is explicit (never implicit)

## Future Work
- Seed data types, data migration ADTs, multi-tenant schema isolation
