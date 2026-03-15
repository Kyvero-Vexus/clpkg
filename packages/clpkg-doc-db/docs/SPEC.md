# clpkg-doc-db — Specification
Coalton-first document database model. 14 ADTs + 4 functions: JsonValue, Document, Collection, DocQuery, QueryOperator, SortOrder/Field, Projection, DocIndex, IndexType, WriteResult, BulkOperation, ChangeEvent, DocResult.
## Security
- Typed query operators prevent injection; change streams enable audit; capped collections bound growth.
