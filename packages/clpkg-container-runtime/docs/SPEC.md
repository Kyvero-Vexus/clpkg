# clpkg-container-runtime — Specification

## Overview

Coalton-first typed domain model for container runtime management within CL-EMACS.
Provides ADTs for container lifecycle, image references, cgroup resource limits,
network modes, volume mounts, and runtime configuration.

## Module: `Core.RuntimeTypes`

### ADTs (14 total)

| Type | Purpose | Constructors |
|------|---------|-------------|
| `ContainerState` | Lifecycle states | Created, Running, Paused, Stopped, Restarting, Removing, Dead |
| `ImageRef` | OCI image reference | registry/repository:tag triple |
| `ImagePullPolicy` | When to pull | Always, IfNotPresent, Never |
| `Namespace` | Isolation boundary | name + active flag |
| `CgroupVersion` | Resource control version | V1, V2 |
| `CgroupConfig` | Resource limits | CPU shares/quota, memory, PIDs |
| `NetworkMode` | Container networking | Bridge, Host, None, Container, Custom |
| `PortMapping` | Port forwarding | host↔container port + protocol |
| `VolumeType` | Storage classification | Bind, Named, Tmpfs, Secret |
| `VolumeMount` | Mount specification | source, target, type, readOnly |
| `ContainerSpec` | Full container definition | image, commands, env, cgroup, network, ports, volumes |
| `ContainerInfo` | Runtime state snapshot | id, name, state, timestamps |
| `RuntimeConfig` | Daemon configuration | socket, storage driver, log driver, debug |
| `RuntimeResult` | Total operation result | Ok a \| Err String |

### Functions (4 total)

| Function | Signature | Purpose |
|----------|-----------|---------|
| `container-running-p` | `ContainerState → Bool` | Check if container is in Running state |
| `image-tag` | `ImageRef → String` | Extract tag from image reference |
| `cgroup-memory-limit-bytes` | `CgroupConfig → Int` | Convert MiB limit to bytes |
| `volume-readonly-p` | `VolumeMount → Bool` | Check read-only flag |

## Security Considerations

- **Namespace isolation**: Each container operates within a named namespace; `active` flag
  prevents operations on deactivated namespaces.
- **Cgroup enforcement**: Resource limits are mandatory fields (no unbounded containers).
- **Volume permissions**: Read-only flag on mounts; `SecretVolume` type for sensitive data.
- **Network segmentation**: `NoneNetwork` mode for fully isolated containers.
- **Image provenance**: `ImageRef` includes registry for supply-chain tracking.

## Performance Budget

| Operation | Target | Notes |
|-----------|--------|-------|
| ADT construction | < 1μs | Pure value types, no allocation overhead |
| State pattern match | < 100ns | Single-level match on sum type |
| Cgroup byte conversion | < 50ns | Integer multiplication only |
| Surface verification | < 2s | Full 18-check suite |

## Dependencies

- Coalton (type system)
- No external runtime dependencies (pure domain model)

## Future Work

- OCI runtime spec compliance layer
- Rootless container support ADTs
- Seccomp profile types
- Image layer/manifest types
