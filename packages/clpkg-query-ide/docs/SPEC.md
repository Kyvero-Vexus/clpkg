# clpkg-query-ide — Specification

## Overview

Coalton-first typed domain model for a database query IDE/client within CL-EMACS.
Provides ADTs for queries, result sets, connections, schema introspection,
execution plans, and query history.

## Module: `Core.QueryTypes`

### ADTs (14 total)

| Type | Purpose | Constructors |
|------|---------|-------------|
| `ColumnType` | SQL column types | Integer, Float, Text, Boolean, Timestamp, Blob, Json, Null, Custom |
| `ColumnDef` | Column definition | name, type, nullable, primaryKey |
| `ResultSet` | Query results | columns, rows, rowCount, execTime |
| `QueryLanguage` | Query dialect | SQL, SPARQL, Cypher, GraphQL, Custom |
| `Query` | Query definition | text, language, database, readOnly, timeout |
| `QueryStatus` | Execution state | Pending, Running, Complete, Failed, Cancelled |
| `ConnectionDriver` | DB driver | PostgreSQL, MySQL, SQLite, MongoDB, Redis, Custom |
| `Connection` | DB connection | name, driver, host, port, database, connected |
| `SchemaObject` | Schema element | Table, View, Index, Function |
| `SchemaInfo` | Schema summary | name, objects, lastRefreshed |
| `PlanNode` | Plan tree node | operation, estimatedRows, cost, children |
| `ExecutionPlan` | Full plan | root node, totalCost, planTime |
| `HistoryEntry` | Query history | id, query, status, timestamp, bookmarked |
| `QueryResult` | Total result | Ok a \| Err String |

### Functions (4 total)

| Function | Signature | Purpose |
|----------|-----------|---------|
| `resultset-row-count` | `ResultSet → Int` | Get result row count |
| `query-is-readonly` | `Query → Bool` | Check read-only flag |
| `connection-active-p` | `Connection → Bool` | Check connection status |
| `plan-estimated-cost` | `ExecutionPlan → Double` | Get plan cost estimate |

## Security Considerations

- **Read-only queries**: `Query.readOnly` flag prevents accidental mutations.
- **Connection isolation**: Each connection is a separate typed value (no shared state).
- **Query timeout**: Mandatory timeout prevents runaway queries.
- **History audit**: `HistoryEntry` preserves executed queries with timestamps.
- **Credential handling**: Connection credentials are external (not in ADTs).

## Performance Budget

| Operation | Target |
|-----------|--------|
| ADT construction | < 1μs |
| Row count access | < 100ns (field access) |
| Plan cost access | < 100ns |
| Surface verification | < 2s |

## Future Work

- Query autocompletion types
- Result set pagination/streaming
- Multi-database transaction types
- Query plan diff/comparison
