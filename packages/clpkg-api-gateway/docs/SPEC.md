# clpkg-api-gateway — Specification

## Overview

Coalton-first typed domain model for API gateway management within CL-EMACS.
Provides ADTs for route matching, rate limiting, authentication policies,
request/response transforms, upstream management, CORS, and gateway configuration.

## Module: `Core.GatewayTypes`

### ADTs (15 total)

| Type | Purpose | Constructors |
|------|---------|-------------|
| `HttpMethod` | HTTP verbs | GET, POST, PUT, DELETE, PATCH, OPTIONS, HEAD, AnyMethod |
| `Route` | Route definition | name, match, methods, upstream, stripPrefix, timeout |
| `RouteMatch` | Match criteria | Exact, Prefix, Regex |
| `RateLimitWindow` | Rate window | PerSecond, PerMinute, PerHour |
| `RateLimiter` | Rate limit config | name, maxRequests, window, keyExtractor |
| `AuthType` | Auth mechanism | JWT, ApiKey, Basic, OAuth2, NoAuth |
| `AuthPolicy` | Auth configuration | name, type, required, excludePaths |
| `TransformOp` | Transform operation | AddHeader, RemoveHeader, RewritePath, AddQueryParam, SetBody |
| `RequestTransform` | Request pipeline | name, operations list |
| `ResponseTransform` | Response pipeline | name, operations list |
| `UpstreamTarget` | Backend target | host, port, weight, healthy |
| `Upstream` | Backend service | name, targets, loadBalancer, healthCheckInterval |
| `CorsConfig` | CORS settings | origins, methods, headers, credentials, maxAge |
| `GatewayConfig` | Full gateway | name, port, routes, upstreams, limiters, auth, cors |
| `GatewayResult` | Total result | Ok a \| Err String |

### Functions (4 total)

| Function | Signature | Purpose |
|----------|-----------|---------|
| `route-matches-method` | `Route → HttpMethod → Bool` | Check if route accepts method |
| `rate-limit-exceeded-p` | `RateLimiter → Int → Bool` | Check if current count exceeds limit |
| `auth-required-p` | `AuthPolicy → Bool` | Check if auth is mandatory |
| `upstream-healthy-count` | `Upstream → Int` | Count healthy backend targets |

## Security Considerations

- **Auth-first routing**: `AuthPolicy` evaluated before request forwarding.
- **Rate limiting**: Per-key extraction prevents single-client abuse.
- **CORS strictness**: Explicit allowlists for origins, methods, headers.
- **Path exclusions**: `AuthPolicy.excludePaths` for health/readiness endpoints only.
- **TLS termination**: Assumed at gateway edge (not modeled in ADTs; runtime concern).

## Performance Budget

| Operation | Target |
|-----------|--------|
| Route matching | < 1μs (string comparison) |
| Rate limit check | < 100ns (integer comparison) |
| Upstream health count | O(n) targets, < 10μs typical |
| Surface verification | < 2s |

## Dependencies

- Coalton (type system)
- No external runtime dependencies

## Future Work

- WebSocket upgrade types
- Circuit breaker integration (link to clpkg-service-mesh)
- Request/response body schema validation types
- Plugin/middleware chain ADTs
