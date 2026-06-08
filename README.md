# Altimate dbt PR Review Demo

A small, zero-secret dbt + DuckDB project that demonstrates
[Altimate dbt PR Review](https://github.com/AltimateAI/altimate-code/tree/main/github/review).

Every demo pull request compiles successfully. The point is to show risks that
ordinary compilation misses: semantic changes, join fan-out, test removal, PII
exposure, warehouse-cost regressions, and unsafe incremental configuration.

## Run Locally

```bash
python -m pip install "dbt-duckdb>=1.8,<2.0"
dbt seed
dbt build
dbt docs generate
```

Review a local branch with Altimate:

```bash
altimate review --base main --head HEAD --manifest target/manifest.json
```

No Altimate account or model key is required. The optional LLM reviewer is
disabled in the GitHub workflow; all launch-demo findings are deterministic.

## Demo Pull Requests

| Branch | Scenario | Expected signal |
|---|---|---|
| `demo/safe-refactor` | Rename and reorganize CTEs without changing behavior | `APPROVE` or non-blocking comment |
| `demo/join-key-breakage` | Join orders to customers on the wrong key | semantic/join risk |
| `demo/test-removal` | Remove primary-key tests from a mart | contract/test warning |
| `demo/new-pii-exposure` | Add customer email to a public mart | PII/lineage risk |
| `demo/mart-select-star` | Replace explicit mart columns with `SELECT *` | SQL quality/cost warning |
| `demo/incremental-without-guard` | Convert a model to incremental without a guard | materialization warning |

The scenario definitions live in
[`demo-cases/cases.yml`](demo-cases/cases.yml).

## Security

The workflow runs on `pull_request`, not `pull_request_target`. It uses DuckDB
and synthetic CSV seeds, so it needs no warehouse credentials or GitHub
secrets. The review action receives only compiled dbt artifacts and the git
diff.
