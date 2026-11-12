# Coalition Database CI/CD Proof of Concept (Flyway + GitHub Actions + JSM)

This repository contains the complete database migration pipeline demonstrating automated, headless database deployments triggered via Jira Service Management (JSM) electronic CAB approval.

## Structure
- `.github/workflows/`
  - `ci-validate.yml`: Runs on PR. Lints SQL and tests both forward (`V__*.sql`) and rollback (`U__*.sql`) migrations against an ephemeral database container.
  - `prod-deploy.yml`: Triggered by JSM CAB Approval via GitHub `repository_dispatch`. Headlessly executes `flyway migrate` against the cloud database, updates the JSM issue with the commit SHA and execution log, and triggers automated rollback if any step fails.
- `sql/`
  - `V1__init_shipment_schema.sql`: Base schema (tables, indexes).
  - `V2__add_shipment_archive_column.sql`: DDL mutation (adding column).
  - `U2__drop_shipment_archive_column.sql`: Rollback script for V2.
  - `R__fn_calculate_shipment_tax.sql`: Repeatable migration (function / stored proc).
- `jira/`
  - `automation-rule.json`: Importable Jira Service Management automation rule definition.
  - `webhook-payload.json`: Reference payload dispatched from JSM to GitHub Actions.

## Quick Start
1. Push this folder to your GitHub repository.
2. Add secrets to GitHub Settings -> Secrets -> Actions:
   - `PROD_DB_JDBC_URL`
   - `PROD_DB_USER`
   - `PROD_DB_PASSWORD`
   - `JIRA_URL` (e.g. `https://your-domain.atlassian.net`)
   - `JIRA_USER_EMAIL`
   - `JIRA_API_TOKEN`
3. In JSM, configure an automation rule on transition to `CAB Approved` to send a POST web request to:
   `https://api.github.com/repos/<org>/<repo>/dispatches` with event type `jira-cab-approved`.
