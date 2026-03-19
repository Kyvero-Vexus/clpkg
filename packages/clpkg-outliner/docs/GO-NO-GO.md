# 1.0 Go/No-Go decision guide

## GO criteria
- E2E authoring flow passes (`tests/e2e/authoring-flow.lisp`).
- Security/property/perf gates pass (`scripts/verify-gates.lisp`).
- API/conditions docs frozen for semver 1.0.

## NO-GO triggers
- Any invariant bypass allowing cyclic tree or dangling parent refs.
- Gate script regression on malformed corpus or property run.
- Unresolved API-breaking changes after freeze.

## Known risks
1. **Perf metric fidelity**: current microbench uses internal time units; add higher-resolution benchmark harness in CI.
2. **Fuzz depth**: malformed corpus is minimal; expand with generated adversarial S-expressions.
3. **Persistence format evolution**: v1 s-expression schema has no migration layer yet.
