# clpkg-secret-manager — Specification

## Overview

Coalton-first typed domain model for secret management within CL-EMACS.
Provides ADTs for secret entries, vault backends, access policies,
rotation schedules, audit events, and encryption algorithms.

## Module: `Core.SecretTypes`

### ADTs (13 total)

| Type | Purpose | Constructors |
|------|---------|-------------|
| `EncryptionAlgorithm` | Cipher selection | AES256GCM, ChaCha20Poly1305, RSA4096, Ed25519 |
| `SecretVersion` | Versioned secret | version number, timestamp, active flag |
| `SecretEntry` | Secret with metadata | name, path, algorithm, versions, tags |
| `SecretMetadata` | Non-sensitive metadata | name, version count, created/accessed timestamps |
| `VaultBackendType` | Backend classification | File, KV, Transit, AWS, GCP, Azure |
| `VaultBackend` | Backend configuration | name, type, endpoint, sealed status |
| `AccessLevel` | Permission level | Read, Write, Delete, Admin |
| `AccessPolicy` | RBAC policy | name, identity, permissions, allowed paths, TTL |
| `RotationFrequency` | Rotation interval | Daily, Weekly, Monthly, Custom |
| `RotationSchedule` | Rotation config | path, frequency, last rotation, auto flag |
| `AuditAction` | Audit event type | Read, Write, Delete, Rotate, PolicyChange |
| `AuditEvent` | Audit log entry | action, path, identity, timestamp, source IP |
| `SecretResult` | Total operation result | Ok a \| Err String |

### Functions (4 total)

| Function | Signature | Purpose |
|----------|-----------|---------|
| `secret-is-active` | `SecretEntry → Bool` | Check if latest version is active |
| `secret-age-days` | `SecretMetadata → Int → Int` | Compute age in days |
| `rotation-due-p` | `RotationSchedule → Int → Bool` | Check if rotation overdue |
| `access-permitted-p` | `AccessPolicy → AccessLevel → String → Bool` | Evaluate access policy |

## Security Considerations

- **No plaintext in types**: `SecretEntry` holds metadata + versions; actual secret values
  are never stored in ADTs (handled by vault backend at runtime).
- **Sealed vault detection**: `VaultBackend.sealedP` prevents operations on sealed vaults.
- **Path-scoped policies**: `AccessPolicy.allowedPaths` restricts access to specific secret paths.
- **TTL enforcement**: `AccessPolicy.ttlSeconds` enables time-bounded access tokens.
- **Audit trail**: Every secret operation produces an `AuditEvent` with source IP tracking.
- **Rotation enforcement**: `rotation-due-p` enables automated secret rotation checks.

## Performance Budget

| Operation | Target |
|-----------|--------|
| ADT construction | < 1μs |
| Policy evaluation | < 1μs (list membership) |
| Rotation check | < 100ns (integer arithmetic) |
| Surface verification | < 2s |

## Dependencies

- Coalton (type system)
- No external runtime dependencies

## Future Work

- Dynamic secret generation types
- PKI / certificate management ADTs
- Secret sharing (Shamir) types
- Multi-tenant vault namespacing
