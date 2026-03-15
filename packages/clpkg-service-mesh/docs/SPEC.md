# clpkg-service-mesh — Specification

## Overview

Coalton-first typed domain model for service mesh control plane within CL-EMACS.
Provides ADTs for proxy configuration, circuit breakers, load balancing,
retry policies, mTLS, health checks, and traffic policies.

## Module: `Core.MeshTypes`

### ADTs (15 total)

| Type | Purpose | Constructors |
|------|---------|-------------|
| `Protocol` | Network protocol | HTTP, HTTPS, GRPC, TCP |
| `ServiceEndpoint` | Service instance | name, host, port, protocol, healthy, weight |
| `HealthCheckType` | Check mechanism | Http (path+status), Tcp, Grpc |
| `HealthCheckPolicy` | Check configuration | type, interval, timeout, threshold |
| `LoadBalancerPolicy` | LB algorithm | RoundRobin, LeastConnections, Random, Weighted, ConsistentHash |
| `CircuitBreakerState` | CB state machine | Closed, Open (timestamp), HalfOpen (trials) |
| `CircuitBreakerConfig` | CB parameters | maxRequests, failureThreshold, successThreshold, timeout |
| `RetryBackoff` | Backoff strategy | Constant, Exponential, None |
| `RetryPolicy` | Retry configuration | maxRetries, backoff, retryableStatusCodes |
| `MtlsMode` | mTLS enforcement | Strict, Permissive, Disabled |
| `MtlsConfig` | mTLS certificates | mode, caCert, cert, key paths |
| `ProxySidecar` | Sidecar proxy | name, inbound/outbound/admin ports |
| `ProxyConfig` | Full proxy config | sidecar, upstreams, LB, CB, retry, mTLS |
| `TrafficPolicy` | Per-service limits | serviceName, maxConnections, rateLimit |
| `MeshResult` | Total result | Ok a \| Err String |

### Functions (4 total)

| Function | Signature | Purpose |
|----------|-----------|---------|
| `endpoint-healthy-p` | `ServiceEndpoint → Bool` | Check endpoint health |
| `circuit-open-p` | `CircuitBreakerState → Bool` | Check if circuit is open |
| `max-retries` | `RetryPolicy → Int` | Get max retry count |
| `mtls-enabled-p` | `MtlsConfig → Bool` | Check if mTLS is active |

## Security Considerations

- **mTLS enforcement**: `Strict` mode requires mutual TLS for all service-to-service traffic.
- **Certificate path isolation**: Cert/key paths are strings (no embedded secrets in ADTs).
- **Circuit breaker protection**: Prevents cascade failures across mesh.
- **Health check gating**: Unhealthy endpoints excluded from load balancing.
- **Traffic policy limits**: Per-service connection/rate caps prevent resource exhaustion.

## Performance Budget

| Operation | Target |
|-----------|--------|
| Endpoint health check | < 100ns (boolean field) |
| Circuit state match | < 100ns |
| mTLS mode check | < 100ns |
| Surface verification | < 2s |

## Dependencies

- Coalton (type system)
- No external runtime dependencies

## Future Work

- Envoy xDS protocol types
- Distributed tracing context propagation
- Fault injection types (delay, abort)
- Multi-cluster mesh federation
