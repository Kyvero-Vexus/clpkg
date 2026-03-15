# clpkg-graph-db — Specification

## Overview
Coalton-first graph database domain model. ADTs for nodes, edges, properties,
traversals, pattern matching, indexing, transactions, and configuration.

## Module: `Core.GraphTypes` — 14 ADTs + 4 functions
PropertyValue, NodeLabel, GraphNode, EdgeType, GraphEdge, TraversalDirection/Step,
PathResult, GraphPattern, MatchClause, GraphIndex, GraphTransaction, GraphConfig, GraphResult.

## Security
- Property value types prevent injection (no raw SQL/Cypher)
- Transaction isolation levels (ReadOnly, ReadWrite, Batch)
- Index types support full-text search with explicit label scoping
