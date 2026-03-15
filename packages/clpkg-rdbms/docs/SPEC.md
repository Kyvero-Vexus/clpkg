# clpkg-rdbms — Specification
Coalton-first relational DB server model. 14 ADTs + 4 functions: SqlType, ColumnConstraint/Def, TableDef, ForeignKey, IndexDef, SqlValue, Row, ResultSet, TransactionIsolation, Transaction, QueryPlan, PlanNodeType, RdbmsResult.
## Security
- Transaction isolation levels prevent dirty reads; foreign key constraints enforce referential integrity; column constraints enforce data quality.
