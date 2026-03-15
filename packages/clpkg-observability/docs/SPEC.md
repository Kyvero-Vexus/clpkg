# clpkg-observability — Specification

## Overview

Coalton-first typed domain model for observability within CL-EMACS.
OpenTelemetry-aligned ADTs for metrics, traces, logs, spans, exporters,
and alerting rules.

## Module: `Core.ObsTypes`

### ADTs (15 total)

| Type | Purpose | Constructors |
|------|---------|-------------|
| `MetricType` | Metric classification | Counter, Gauge, Histogram, Summary |
| `MetricValue` | Typed metric value | IntMetric, FloatMetric, HistogramMetric |
| `Metric` | Named metric | name, type, value, labels, timestamp |
| `SpanKind` | OTel span kind | Server, Client, Producer, Consumer, Internal |
| `SpanStatus` | Span outcome | SpanOk, SpanError, SpanUnset |
| `Span` | Trace span | traceId, spanId, parentId, name, kind, status, start, end |
| `TraceContext` | Propagation context | traceId, spanId, flags |
| `LogLevel` | Log severity | Trace, Debug, Info, Warn, Error, Fatal |
| `LogEntry` | Structured log | level, message, timestamp, attributes, traceId |
| `ExporterType` | Export target | OtlpGrpc, OtlpHttp, Prometheus, Jaeger, Stdout |
| `ExporterConfig` | Exporter setup | name, type, endpoint, batchSize, flushInterval |
| `AlertSeverity` | Alert level | AlertCritical, AlertWarning, AlertInfo |
| `AlertRule` | Alert definition | name, condition, severity, cooldown, recipients |
| `SamplingStrategy` | Trace sampling | AlwaysOn, AlwaysOff, TraceIdRatio, ParentBased |
| `ObsResult` | Total result | Ok a \| Err String |

### Functions (5 total)

| Function | Signature | Purpose |
|----------|-----------|---------|
| `span-duration-ms` | `Span → Int` | Compute span duration |
| `span-is-root` | `Span → Bool` | Check if root span |
| `log-is-error` | `LogEntry → Bool` | Check error/fatal level |
| `metric-is-counter` | `Metric → Bool` | Check counter type |
| `alert-is-critical` | `AlertRule → Bool` | Check critical severity |

## Security Considerations

- **Trace context propagation**: `TraceContext` carries only IDs and flags (no secrets).
- **Log sanitization**: `LogEntry.attributes` must not contain credentials (runtime concern).
- **Exporter TLS**: OTLP exporters assume TLS endpoint (not modeled; runtime enforcement).
- **Alert routing**: `AlertRule.recipients` for targeted notification.
- **Sampling**: `AlwaysOff` strategy for sensitive environments.

## Performance Budget

| Operation | Target |
|-----------|--------|
| ADT construction | < 1μs |
| Span duration calc | < 100ns |
| Log level check | < 100ns |
| Surface verification | < 2s |

## Dependencies

- Coalton (type system)
- No external runtime dependencies

## Future Work

- Exemplar types for metrics → traces correlation
- Resource/instrumentation scope types
- Baggage propagation
- SLO/SLI budget tracking types
