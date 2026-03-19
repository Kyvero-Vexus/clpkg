# Condition taxonomy

- `outline-error` — root condition for package failures.
- `outline-parse-error` — malformed serialized input (bad shape/types or read-level parse failures).
- `outline-invariant-error` — structural violations (missing parent, cycle, parent/child mismatch, duplicate IDs).

Recovery stance (v1): fail-closed on parse/invariant violations; callers catch `outline-error` and surface typed diagnostics.
