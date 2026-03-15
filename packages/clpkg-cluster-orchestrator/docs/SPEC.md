# clpkg-cluster-orchestrator — Specification

## Overview

Coalton-first typed domain model for cluster orchestration within CL-EMACS.
Provides ADTs for nodes, pods, deployments, services, scaling policies,
resource quotas, and scheduler configuration.

## Module: `Core.ClusterTypes`

### ADTs (15 total)

| Type | Purpose | Constructors |
|------|---------|-------------|
| `NodeStatus` | Node health | Ready, NotReady, Unknown, Cordon |
| `Node` | Cluster node | name, status, cpu, mem, pods running/capacity |
| `PodPhase` | Pod lifecycle | Pending, Running, Succeeded, Failed, Unknown |
| `ContainerStatus` | Container within pod | Waiting, Running, Terminated |
| `PodContainer` | Container spec in pod | name, image, command, resources, status |
| `Pod` | Kubernetes-style pod | name, namespace, phase, containers, restarts |
| `DeploymentStrategy` | Rollout strategy | RollingUpdate (surge/unavailable), Recreate |
| `Deployment` | Workload deployment | name, namespace, replicas (desired/ready/updated), strategy |
| `ServiceType` | Service exposure | ClusterIP, NodePort, LoadBalancer, ExternalName |
| `Service` | Service definition | name, namespace, type, port, selector |
| `ScalingMetric` | Autoscale trigger | CPU%, Mem%, Custom metric |
| `ScalingPolicy` | HPA-style policy | deployment, min/max replicas, metric, cooldown |
| `ResourceQuota` | Namespace limits | cpu, mem, pod count, storage |
| `SchedulerConfig` | Scheduling rules | selectors, tolerations, preemption |
| `ClusterResult` | Total operation result | Ok a \| Err String |

### Functions (4 total)

| Function | Signature | Purpose |
|----------|-----------|---------|
| `node-ready-p` | `Node → Bool` | Check node readiness |
| `pod-running-p` | `Pod → Bool` | Check pod is running |
| `deployment-available-p` | `Deployment → Bool` | Check all replicas ready |
| `scaling-needed-p` | `ScalingPolicy → Int → Bool` | Check if current replicas out of bounds |

## Security Considerations

- **Namespace isolation**: All pods/services scoped to namespaces.
- **Resource quotas**: Mandatory limits prevent resource starvation.
- **Node cordoning**: `NodeCordon` status prevents new pod scheduling.
- **RBAC preparation**: AccessPolicy types planned for Phase 3.

## Performance Budget

| Operation | Target | Notes |
|-----------|--------|-------|
| ADT construction | < 1μs | Pure value types |
| Node/pod status match | < 100ns | Single-level pattern match |
| Scaling check | < 100ns | Two integer comparisons |
| Surface verification | < 2s | Full 19-check suite |

## Dependencies

- Coalton (type system)
- No external runtime dependencies (pure domain model)

## Future Work

- StatefulSet / DaemonSet ADTs
- Network policy types
- PersistentVolume / StorageClass
- RBAC / ServiceAccount types
