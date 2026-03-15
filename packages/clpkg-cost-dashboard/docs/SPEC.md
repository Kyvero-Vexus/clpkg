# clpkg-cost-dashboard — Specification

## Overview

Coalton-first typed domain model for cost governance within CL-EMACS.
Provides ADTs for cloud resource costs, budgets, forecasts, cost allocation,
and optimization recommendations.

## Module: `Core.CostTypes`

### ADTs (13 total)

| Type | Purpose | Constructors |
|------|---------|-------------|
| `Currency` | Currency code | USD, EUR, GBP, JPY, CustomCurrency |
| `CostEntry` | Line item | service, resource, amount, currency, timestamp |
| `CostPeriod` | Time range | Daily, Weekly, Monthly, Quarterly, Yearly |
| `Budget` | Budget definition | name, limit, currency, period, alertThresholds |
| `BudgetStatus` | Budget state | UnderBudget, NearBudget, OverBudget, Exhausted |
| `Forecast` | Cost forecast | period, projected, confidence, trend |
| `CostTrend` | Trend direction | Increasing, Decreasing, Stable, Volatile |
| `CostAllocation` | Cost attribution | team, project, environment, amount, tags |
| `OptimizationType` | Savings category | RightSizing, Reserved, Spot, Unused, Storage |
| `Recommendation` | Optimization rec | type, resource, currentCost, projectedSaving, confidence |
| `CostAlert` | Alert instance | budgetName, threshold, currentSpend, triggered |
| `CostReport` | Aggregated report | period, entries, total, currency, generatedAt |
| `CostResult` | Total result | Ok a \| Err String |

### Functions (4 total)

| Function | Signature | Purpose |
|----------|-----------|---------|
| `budget-remaining` | `Budget → Int → Int` | Calculate remaining budget |
| `budget-utilization-pct` | `Budget → Int → Int` | Budget usage percentage |
| `over-budget-p` | `Budget → Int → Bool` | Check if over budget |
| `recommendation-savings-pct` | `Recommendation → Int` | Projected savings percentage |

## Security Considerations

- **Cost data sensitivity**: Cost entries may reveal infrastructure scale; access-control is runtime concern.
- **Budget alert routing**: `CostAlert` triggers go to budget owners only.
- **No credential storage**: Provider API keys for cost APIs are external.
- **Tag-based allocation**: `CostAllocation.tags` enable fine-grained attribution without org chart exposure.

## Performance Budget

| Operation | Target |
|-----------|--------|
| ADT construction | < 1μs |
| Budget calculation | < 100ns (integer arithmetic) |
| Utilization percentage | < 100ns |
| Surface verification | < 2s |

## Dependencies

- Coalton (type system)
- No external runtime dependencies

## Future Work

- Multi-cloud cost normalization
- Anomaly detection types
- Chargeback/showback report types
- FinOps maturity model scoring
