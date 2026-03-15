# clpkg-iac-runner — Specification

## Overview

Coalton-first typed domain model for Infrastructure-as-Code execution within CL-EMACS.
Provides ADTs for resource specifications, plan/apply lifecycle, drift detection,
provider configuration, and state backends.

## Module: `Core.IacTypes`

### ADTs (15 total)

| Type | Purpose | Constructors |
|------|---------|-------------|
| `ResourceType` | Infrastructure category | Compute, Storage, Network, Database, Security, Dns, Custom |
| `ResourceState` | Lifecycle state | Planned, Creating, Created, Updating, Deleting, Deleted, Failed |
| `ResourceSpec` | Resource definition | name, type, provider, properties, dependencies |
| `PlanActionType` | Plan operation | Create, Update, Delete, Replace, NoOp |
| `PlanAction` | Planned change | resource, action, reason, diff |
| `ExecutionPlan` | Plan bundle | id, actions, timestamp, autoApprove |
| `ApplyStatus` | Apply lifecycle | Pending, InProgress, Succeeded, Failed, RolledBack |
| `ApplyResult` | Apply outcome | planId, status, created/updated/deleted counts |
| `DriftSeverity` | Drift classification | Critical, Warning, Info |
| `DriftEntry` | Individual drift | resource, field, severity, expected, actual |
| `DriftReport` | Drift summary | timestamp, entries, hasBreaking |
| `ProviderType` | Cloud provider | AWS, GCP, Azure, Local, Custom |
| `ProviderConfig` | Provider setup | name, type, region, credentials, initialized |
| `StateBackend` | State storage | LocalFile, Remote, Consul |
| `IacResult` | Total operation result | Ok a \| Err String |

### Functions (4 total)

| Function | Signature | Purpose |
|----------|-----------|---------|
| `resource-needs-update` | `ResourceState → Bool` | Check if resource is in transitional state |
| `plan-action-count` | `ExecutionPlan → Int` | Count actions in plan |
| `drift-has-breaking` | `DriftReport → Bool` | Check for breaking drift |
| `apply-succeeded-p` | `ApplyResult → Bool` | Check apply success |

## Security Considerations

- **Credential isolation**: `ProviderConfig.credentialPath` is a path reference, not inline secret.
- **Plan approval gate**: `autoApprove` flag on `ExecutionPlan`; defaults to requiring human review.
- **Drift severity classification**: `DriftCritical` triggers immediate alerts.
- **State backend encryption**: Remote backends support encrypted state files.
- **Rollback tracking**: `ApplyRolledBack` status preserves audit trail.

## Performance Budget

| Operation | Target |
|-----------|--------|
| ADT construction | < 1μs |
| Plan action counting | < 1μs (list traversal) |
| Drift check | < 100ns |
| Surface verification | < 2s |

## Dependencies

- Coalton (type system)
- No external runtime dependencies

## Future Work

- Terraform state format parser
- Policy-as-code evaluation types
- Cost estimation ADTs
- Multi-region deployment types
