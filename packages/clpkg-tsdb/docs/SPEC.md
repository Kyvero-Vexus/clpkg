# clpkg-tsdb — Specification

## Overview
Coalton-first time-series database domain model. ADTs for data points, series,
aggregation, retention tiers, downsampling, write buffering, compaction, and sharding.

## Module: `Core.TsdbTypes` — 14 ADTs + 4 functions
TimeResolution, DataPoint, TimeSeries, AggregateFunction/Result, RetentionTier,
DownsamplePolicy, QueryRange, TsQuery, WriteBuffer, CompactionState, ShardKey,
TsdbConfig, TsdbResult.

## Security
- Retention enforcement prevents unbounded storage growth
- Write buffer capacity limits prevent OOM
- Shard isolation for multi-tenant workloads
