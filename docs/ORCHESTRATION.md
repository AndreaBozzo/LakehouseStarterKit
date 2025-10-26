# 🔄 Orchestration with Prefect

This guide explains how to use Prefect to orchestrate and schedule the data pipeline.

## Overview

The Lakehouse Starter Kit uses **Prefect 3** for workflow orchestration. Prefect provides:

- **Scheduled pipeline execution** (e.g., daily at 2 AM)
- **Retry logic** for resilient data pipelines
- **Monitoring dashboard** to track pipeline health
- **Error notifications** when pipelines fail
- **Task caching** to optimize execution

## Architecture

```text
Prefect Server (UI + API)
    ↓
E-commerce ETL Flow
    ↓
┌─────────────────────────────────────────────┐
│ Task 1: Data Ingestion (dlt)               │
│   PostgreSQL → MinIO (Parquet)             │
│   Retries: 2, Cache: 1 hour                │
└─────────────────────────────────────────────┘
    ↓
┌─────────────────────────────────────────────┐
│ Task 2: Data Transformation (dbt run)      │
│   MinIO → DuckDB models                    │
│   Retries: 2                               │
└─────────────────────────────────────────────┘
    ↓
┌─────────────────────────────────────────────┐
│ Task 3: Data Quality Tests (dbt test)      │
│   Validate data integrity                  │
│   Retries: 1                               │
└─────────────────────────────────────────────┘
```

## Components

### 1. Prefect Server

**Docker Service**: `prefect-server`
**Port**: 4200
**UI**: http://localhost:4200
**Database**: PostgreSQL (database `prefect`)

The Prefect Server provides:
- Web UI for monitoring flows and runs
- API for flow deployment and execution
- Scheduling engine for automated runs
- Historical data and logs

### 2. E-commerce ETL Flow

**File**: [flows/ecommerce_etl_flow.py](../flows/ecommerce_etl_flow.py)

The main orchestration flow consists of 3 sequential tasks:

#### Task 1: `run_dlt_pipeline`
- **Purpose**: Extract data from PostgreSQL and load to MinIO
- **Retries**: 2 attempts with 60s delay
- **Cache**: 1 hour (avoids re-running if data hasn't changed)
- **Timeout**: 5 minutes
- **Output**: Pipeline stats (tables loaded, record counts)

#### Task 2: `run_dbt_models`
- **Purpose**: Transform raw data into analytics models
- **Retries**: 2 attempts with 30s delay
- **Timeout**: 5 minutes
- **Models**: 4 staging views + 3 marts tables
- **Output**: Number of models created

#### Task 3: `run_dbt_tests`
- **Purpose**: Validate data quality and integrity
- **Retries**: 1 attempt
- **Timeout**: 5 minutes
- **Tests**: 45 data quality tests
- **Output**: Tests passed/failed/warned

### 3. Deployment Script

**File**: [flows/deploy.py](../flows/deploy.py)

Deploys the flow to Prefect Server with schedule configuration.

## Getting Started

### Step 1: Start Prefect Server

Prefect Server is included in `docker-compose.yml`:

```bash
# Start all services (including Prefect)
docker-compose up -d

# Check Prefect Server status
docker logs prefect-server

# Access Prefect UI
open http://localhost:4200
```

**First Startup**: Prefect Server takes 30-60 seconds to initialize the database.

### Step 2: Install Prefect CLI

Prefect is included in `requirements.txt`:

```bash
# Activate virtual environment
source .venv/bin/activate  # Linux/Mac
.venv\Scripts\activate     # Windows

# Install dependencies (includes Prefect)
pip install -r requirements.txt
```

### Step 3: Configure Prefect API

Set the Prefect API URL to connect to the Docker server:

```bash
# Linux/Mac
export PREFECT_API_URL="http://localhost:4200/api"

# Windows (PowerShell)
$env:PREFECT_API_URL="http://localhost:4200/api"

# Windows (CMD)
set PREFECT_API_URL=http://localhost:4200/api
```

Or add to your `.env` file:

```bash
PREFECT_API_URL=http://localhost:4200/api
```

### Step 4: Run Flow Locally (Test)

Before deploying, test the flow locally:

```bash
# Run the flow immediately
python flows/ecommerce_etl_flow.py

# Expected output:
# 🚀 Starting E-commerce ETL Pipeline
# 📥 Stage 1/3: Data Ingestion (dlt)
# ✅ Stage 1 completed
# 🔄 Stage 2/3: Data Transformation (dbt run)
# ✅ Stage 2 completed
# ✅ Stage 3/3: Data Quality Tests (dbt test)
# ✅ Stage 3 completed
# 🎉 E-commerce ETL Pipeline completed successfully!
```

### Step 5: Deploy Flow with Schedule

Deploy the flow to Prefect Server for scheduled execution:

```bash
# Deploy with daily schedule (2 AM)
python flows/deploy.py

# Expected output:
# ✅ Deployment configuration created
#    Name: ecommerce-etl-daily
#    Schedule: Daily at 02:00 AM
# 🚀 Starting deployment server...
#    UI: http://localhost:4200
```

**Note**: Keep the deployment server running in the background. It will serve the flow and execute it according to the schedule.

### Step 6: Monitor in Prefect UI

1. Open http://localhost:4200
2. Navigate to **Flows** → `ecommerce_etl`
3. View:
   - **Upcoming runs** (scheduled)
   - **Recent runs** (history)
   - **Flow details** (tasks, parameters)
   - **Logs** (real-time task output)

### Step 7: Manual Trigger (Optional)

You can manually trigger the flow from the UI:

1. Go to **Flows** → `ecommerce_etl`
2. Click **"Quick Run"**
3. Monitor execution in real-time
4. View logs and results

## Flow Configuration

### Schedule Modification

To change the schedule, edit [flows/deploy.py](../flows/deploy.py):

```python
# Current: Daily at 2 AM
cron="0 2 * * *"

# Examples:
# Every 6 hours:     cron="0 */6 * * *"
# Every Monday 8AM:  cron="0 8 * * 1"
# Every 15 minutes:  cron="*/15 * * * *"
```

After changing, re-deploy:

```bash
python flows/deploy.py
```

### Retry Configuration

Modify retry behavior in [flows/ecommerce_etl_flow.py](../flows/ecommerce_etl_flow.py):

```python
@task(
    name="run_dlt_pipeline",
    retries=2,              # Number of retry attempts
    retry_delay_seconds=60  # Delay between retries
)
```

### Timeout Configuration

Adjust task timeouts:

```python
result = subprocess.run(
    [...],
    timeout=300  # Timeout in seconds (5 minutes)
)
```

## Monitoring & Alerting

### Built-in Monitoring

Prefect UI provides:
- **Flow run history** with success/failure status
- **Real-time logs** for debugging
- **Duration metrics** to track performance
- **Task-level details** for granular insights

### Email Notifications (Optional)

To receive email alerts on failures, configure Prefect notifications:

```bash
# Configure SMTP settings in Prefect UI
# Settings → Notifications → Add Notification

# Set trigger: Flow Run State → Failed
# Set recipients: your-email@example.com
```

### Slack Notifications (Optional)

Install Prefect Slack integration:

```bash
pip install prefect-slack

# Configure in flows/ecommerce_etl_flow.py
from prefect_slack import SlackWebhook

@flow(on_failure=[SlackWebhook(url="SLACK_WEBHOOK_URL")])
def ecommerce_etl_flow():
    ...
```

## Troubleshooting

### Prefect Server Not Starting

**Issue**: Container exits immediately

**Solution**:
```bash
# Check logs
docker logs prefect-server

# Common issue: PostgreSQL database 'prefect' not created
# Solution: Ensure postgres/init/00_databases.sql creates the database

# Restart services
docker-compose restart prefect-server
```

### Flow Deployment Fails

**Issue**: `PREFECT_API_URL` not set or incorrect

**Solution**:
```bash
# Verify Prefect Server is running
curl http://localhost:4200/api/health

# Set API URL
export PREFECT_API_URL="http://localhost:4200/api"

# Retry deployment
python flows/deploy.py
```

### Task Fails: "dlt pipeline failed"

**Issue**: PostgreSQL connection error or MinIO unavailable

**Solution**:
```bash
# Check .env file has correct credentials
cat .env

# Test PostgreSQL connection
docker exec -it postgres psql -U postgres -d ecommerce -c "SELECT COUNT(*) FROM ecommerce.customers;"

# Test MinIO connection
curl http://localhost:9000/minio/health/live

# Verify environment variables in flow execution
# Check Prefect UI → Flow Run → Logs
```

### Task Fails: "dbt run failed"

**Issue**: DuckDB can't access MinIO S3 files

**Solution**:
```bash
# Verify dlt pipeline ran successfully
# Check MinIO Console: http://localhost:9001
# Navigate to bucket: raw/ecommerce/

# Verify .env has S3 credentials
AWS_ACCESS_KEY_ID=admin
AWS_SECRET_ACCESS_KEY=password123

# Test dbt manually
cd dbt
dbt run --profiles-dir .
```

### Scheduled Runs Not Executing

**Issue**: Deployment server stopped or schedule misconfigured

**Solution**:
```bash
# Ensure deployment server is running
python flows/deploy.py

# Keep it running in background or use screen/tmux
# OR use Prefect Agent (production setup)

# Verify schedule in Prefect UI
# Flows → ecommerce_etl → Deployments → ecommerce-etl-daily
```

## Production Deployment

For production environments, use a Prefect Agent instead of `deploy.py`:

### Step 1: Create Work Pool

```bash
prefect work-pool create default-pool --type process
```

### Step 2: Deploy Flow

```bash
prefect deploy flows/ecommerce_etl_flow.py:ecommerce_etl_flow \
  --name ecommerce-etl-daily \
  --pool default-pool \
  --cron "0 2 * * *"
```

### Step 3: Start Agent (Background)

```bash
# Linux/Mac (with screen or tmux)
screen -S prefect-agent
prefect agent start --pool default-pool

# Windows (as a service or background process)
prefect agent start --pool default-pool
```

### Step 4: Monitor

Access Prefect UI and verify:
- Work pool shows active agent
- Deployment is scheduled correctly
- Agent is polling for work

## Advanced Features

### Parallel Task Execution

Modify the flow to run independent tasks in parallel:

```python
from prefect import flow

@flow
def parallel_etl_flow():
    # Run multiple dlt pipelines in parallel
    future1 = run_dlt_pipeline.submit()
    future2 = run_another_pipeline.submit()

    # Wait for both to complete
    future1.result()
    future2.result()

    # Then run dbt
    run_dbt_models()
```

### Conditional Execution

Skip tasks based on conditions:

```python
@flow
def conditional_etl_flow():
    dlt_stats = run_dlt_pipeline()

    # Only run dbt if new data was loaded
    if dlt_stats["status"] == "success":
        run_dbt_models()
```

### Parameterized Flows

Accept parameters for flexible execution:

```python
@flow
def parameterized_etl_flow(
    source_tables: list = ["customers", "orders"],
    full_refresh: bool = False
):
    run_dlt_pipeline(tables=source_tables, full_refresh=full_refresh)
    run_dbt_models()
```

## Resources

- **Prefect Docs**: https://docs.prefect.io
- **Prefect UI**: http://localhost:4200
- **Flow Code**: [flows/ecommerce_etl_flow.py](../flows/ecommerce_etl_flow.py)
- **Deployment Code**: [flows/deploy.py](../flows/deploy.py)

## Next Steps

1. ✅ Deploy flow with `python flows/deploy.py`
2. ✅ Monitor first scheduled run in Prefect UI
3. ⏭️ Configure email/Slack notifications
4. ⏭️ Add more flows for additional data sources
5. ⏭️ Implement Prefect Agent for production

---

**Last Updated**: 2025-10-26
**Version**: 0.0.3
