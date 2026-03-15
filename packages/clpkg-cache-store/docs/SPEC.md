# clpkg-cache-store — Specification

## Overview

Coalton-first typed domain model for in-memory caching within CL-EMACS.
Provides ADTs for cache entries, eviction policies, TTL strategies,
partitioning, warmup sources, and health monitoring.

## Module: `Core.CacheTypes` — 13 ADTs + 4 functions

| Type | Purpose |
|------|---------|
| `EvictionPolicy` | LRU, LFU, FIFO, Random, TTLOnly |
| `CacheEntry` | Key-value with timestamps + access count |
| `CacheStats` | Hits, misses, evictions, size |
| `CacheConfig` | Max entries/size, eviction, TTL, stats toggle |
| `CacheOperation` | Get, Put, Delete, Clear, GetOrCompute |
| `CacheEvent` | Hit, Miss, Eviction, Expiry, Error |
| `TtlPolicy` | Fixed, Sliding, None, PerKey |
| `PartitionStrategy` | Hash, Range, Single |
| `CachePartition` | Partition stats |
| `SerializationFormat` | JSON, Msgpack, Raw, Custom |
| `WarmupSource` | File, Database, API, None |
| `CacheHealth` | Healthy, Degraded, Unhealthy |
| `CacheResult` | Total result type |

## Security
- TTL enforcement prevents stale data
- Per-key TTL for sensitive entries
- Cache events enable audit logging
- Partition isolation for multi-tenant scenarios

## Future Work
- Distributed cache synchronization, write-through/write-back policies, bloom filter types
