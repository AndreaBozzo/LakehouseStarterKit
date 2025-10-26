"""
Prefect Flow: E-commerce ETL Pipeline

This flow orchestrates the complete data pipeline:
1. Extract data from PostgreSQL and load to MinIO (dlt)
2. Transform data with dbt models
3. Run dbt tests for data quality validation

Schedule: Daily at 02:00 AM
"""

import os
import sys
import subprocess
from pathlib import Path
from datetime import datetime, timedelta
from typing import Dict, Any

from prefect import flow, task, get_run_logger
from prefect.tasks import task_input_hash


# ============================================
# Configuration
# ============================================
PROJECT_ROOT = Path(__file__).parent.parent
DLT_PIPELINE_PATH = PROJECT_ROOT / "dlt" / "pipelines" / "ecommerce_postgres.py"
DBT_PROJECT_PATH = PROJECT_ROOT / "dbt"


# ============================================
# Task 1: Data Ingestion (dlt)
# ============================================
@task(
    name="run_dlt_pipeline",
    description="Extract data from PostgreSQL and load to MinIO in Parquet format",
    retries=2,
    retry_delay_seconds=60,
    cache_key_fn=task_input_hash,
    cache_expiration=timedelta(hours=1)
)
def run_dlt_pipeline() -> Dict[str, Any]:
    """
    Run the dlt pipeline to extract e-commerce data from PostgreSQL
    and load it to MinIO (S3-compatible storage).

    Returns:
        Dict with pipeline execution stats
    """
    logger = get_run_logger()
    logger.info("="*60)
    logger.info("Starting dlt pipeline: PostgreSQL → MinIO")
    logger.info("="*60)

    # Load environment variables
    from dotenv import load_dotenv
    load_dotenv(PROJECT_ROOT / ".env")

    # Verify environment variables
    required_vars = [
        'POSTGRES_HOST', 'POSTGRES_PORT', 'POSTGRES_USER',
        'POSTGRES_PASSWORD', 'POSTGRES_DB',
        'AWS_ACCESS_KEY_ID', 'AWS_SECRET_ACCESS_KEY'
    ]

    missing_vars = [var for var in required_vars if not os.getenv(var)]
    if missing_vars:
        raise ValueError(f"Missing required environment variables: {missing_vars}")

    logger.info(f"Running dlt pipeline: {DLT_PIPELINE_PATH}")
    logger.info(f"PostgreSQL: {os.getenv('POSTGRES_HOST')}:{os.getenv('POSTGRES_PORT')}")
    logger.info(f"Destination: s3://raw/ecommerce/")

    # Run dlt pipeline
    try:
        result = subprocess.run(
            [sys.executable, str(DLT_PIPELINE_PATH)],
            cwd=PROJECT_ROOT,
            capture_output=True,
            text=True,
            timeout=300,  # 5 minutes timeout
            check=True
        )

        logger.info("dlt pipeline output:")
        logger.info(result.stdout)

        if result.stderr:
            logger.warning("dlt pipeline warnings:")
            logger.warning(result.stderr)

        logger.info("✅ dlt pipeline completed successfully")

        return {
            "status": "success",
            "pipeline": "ecommerce_postgres_to_s3",
            "destination": "s3://raw/ecommerce/",
            "format": "parquet",
            "timestamp": datetime.now().isoformat()
        }

    except subprocess.CalledProcessError as e:
        logger.error(f"❌ dlt pipeline failed with exit code {e.returncode}")
        logger.error(f"stdout: {e.stdout}")
        logger.error(f"stderr: {e.stderr}")
        raise

    except subprocess.TimeoutExpired:
        logger.error("❌ dlt pipeline timed out after 5 minutes")
        raise


# ============================================
# Task 2: Data Transformation (dbt run)
# ============================================
@task(
    name="run_dbt_models",
    description="Run dbt transformations to create staging views and marts tables",
    retries=2,
    retry_delay_seconds=30
)
def run_dbt_models() -> Dict[str, Any]:
    """
    Run dbt models to transform data from MinIO into analytics-ready tables.

    Returns:
        Dict with dbt run stats
    """
    logger = get_run_logger()
    logger.info("="*60)
    logger.info("Starting dbt transformations")
    logger.info("="*60)

    logger.info(f"dbt project path: {DBT_PROJECT_PATH}")
    logger.info("Running: dbt run")

    # Load environment variables for DuckDB S3 access
    from dotenv import load_dotenv
    load_dotenv(PROJECT_ROOT / ".env")

    # Run dbt models
    try:
        result = subprocess.run(
            ["dbt", "run", "--profiles-dir", "."],
            cwd=DBT_PROJECT_PATH,
            capture_output=True,
            text=True,
            timeout=300,  # 5 minutes timeout
            check=True,
            env={**os.environ}  # Pass environment variables
        )

        logger.info("dbt run output:")
        logger.info(result.stdout)

        if result.stderr:
            logger.warning("dbt run warnings:")
            logger.warning(result.stderr)

        # Parse dbt output for stats (models created)
        models_run = result.stdout.count("OK created")

        logger.info(f"✅ dbt run completed: {models_run} models created")

        return {
            "status": "success",
            "models_run": models_run,
            "timestamp": datetime.now().isoformat()
        }

    except subprocess.CalledProcessError as e:
        logger.error(f"❌ dbt run failed with exit code {e.returncode}")
        logger.error(f"stdout: {e.stdout}")
        logger.error(f"stderr: {e.stderr}")
        raise

    except subprocess.TimeoutExpired:
        logger.error("❌ dbt run timed out after 5 minutes")
        raise


# ============================================
# Task 3: Data Quality Tests (dbt test)
# ============================================
@task(
    name="run_dbt_tests",
    description="Run dbt tests for data quality validation",
    retries=1,
    retry_delay_seconds=30
)
def run_dbt_tests() -> Dict[str, Any]:
    """
    Run dbt tests to validate data quality and integrity.

    Returns:
        Dict with dbt test stats
    """
    logger = get_run_logger()
    logger.info("="*60)
    logger.info("Starting dbt data quality tests")
    logger.info("="*60)

    logger.info(f"dbt project path: {DBT_PROJECT_PATH}")
    logger.info("Running: dbt test")

    # Load environment variables
    from dotenv import load_dotenv
    load_dotenv(PROJECT_ROOT / ".env")

    # Run dbt tests
    try:
        result = subprocess.run(
            ["dbt", "test", "--profiles-dir", "."],
            cwd=DBT_PROJECT_PATH,
            capture_output=True,
            text=True,
            timeout=300,  # 5 minutes timeout
            check=True,
            env={**os.environ}
        )

        logger.info("dbt test output:")
        logger.info(result.stdout)

        if result.stderr:
            logger.warning("dbt test warnings:")
            logger.warning(result.stderr)

        # Parse dbt output for stats
        tests_passed = result.stdout.count("PASS")
        tests_failed = result.stdout.count("FAIL")
        tests_warned = result.stdout.count("WARN")

        logger.info(f"✅ dbt tests completed: {tests_passed} passed, {tests_failed} failed, {tests_warned} warnings")

        if tests_failed > 0:
            raise ValueError(f"dbt tests failed: {tests_failed} tests did not pass")

        return {
            "status": "success",
            "tests_passed": tests_passed,
            "tests_failed": tests_failed,
            "tests_warned": tests_warned,
            "timestamp": datetime.now().isoformat()
        }

    except subprocess.CalledProcessError as e:
        logger.error(f"❌ dbt test failed with exit code {e.returncode}")
        logger.error(f"stdout: {e.stdout}")
        logger.error(f"stderr: {e.stderr}")
        raise

    except subprocess.TimeoutExpired:
        logger.error("❌ dbt test timed out after 5 minutes")
        raise


# ============================================
# Main Flow: E-commerce ETL
# ============================================
@flow(
    name="ecommerce_etl",
    description="Complete ETL pipeline: PostgreSQL → MinIO → dbt → Quality Tests",
    log_prints=True
)
def ecommerce_etl_flow() -> Dict[str, Any]:
    """
    Main orchestration flow for the e-commerce data pipeline.

    Pipeline stages:
    1. Extract from PostgreSQL, load to MinIO (dlt)
    2. Transform data with dbt models (staging + marts)
    3. Run data quality tests (dbt test)

    Returns:
        Dict with overall pipeline stats
    """
    logger = get_run_logger()

    logger.info("🚀 Starting E-commerce ETL Pipeline")
    logger.info(f"⏰ Execution time: {datetime.now().isoformat()}")
    logger.info("="*60)

    pipeline_start = datetime.now()

    try:
        # Stage 1: Data Ingestion
        logger.info("📥 Stage 1/3: Data Ingestion (dlt)")
        dlt_stats = run_dlt_pipeline()
        logger.info(f"✅ Stage 1 completed: {dlt_stats}")

        # Stage 2: Data Transformation
        logger.info("🔄 Stage 2/3: Data Transformation (dbt run)")
        dbt_run_stats = run_dbt_models()
        logger.info(f"✅ Stage 2 completed: {dbt_run_stats}")

        # Stage 3: Data Quality Tests
        logger.info("✅ Stage 3/3: Data Quality Tests (dbt test)")
        dbt_test_stats = run_dbt_tests()
        logger.info(f"✅ Stage 3 completed: {dbt_test_stats}")

        # Calculate duration
        pipeline_end = datetime.now()
        duration = (pipeline_end - pipeline_start).total_seconds()

        logger.info("="*60)
        logger.info("🎉 E-commerce ETL Pipeline completed successfully!")
        logger.info(f"⏱️  Total duration: {duration:.2f} seconds")
        logger.info("="*60)

        return {
            "status": "success",
            "duration_seconds": duration,
            "stages": {
                "dlt": dlt_stats,
                "dbt_run": dbt_run_stats,
                "dbt_test": dbt_test_stats
            },
            "completed_at": pipeline_end.isoformat()
        }

    except Exception as e:
        logger.error("="*60)
        logger.error(f"❌ Pipeline failed: {str(e)}")
        logger.error("="*60)
        raise


# ============================================
# Deployment Configuration
# ============================================
if __name__ == "__main__":
    """
    Run the flow directly or deploy it to Prefect Server.

    Usage:
        # Run locally:
        python flows/ecommerce_etl_flow.py

        # Deploy to Prefect Server:
        python flows/ecommerce_etl_flow.py --deploy
    """
    import argparse

    parser = argparse.ArgumentParser(description="E-commerce ETL Flow")
    parser.add_argument(
        "--deploy",
        action="store_true",
        help="Deploy flow to Prefect Server"
    )
    args = parser.parse_args()

    if args.deploy:
        # Serve flow with schedule using Prefect 3 API (local development)
        print("✅ Registering flow deployment to Prefect Server")
        print("📅 Schedule: Daily at 02:00 AM")
        print("🔗 UI: http://localhost:4200")
        print("\n⚠️  Note: For local development, the flow is registered.")
        print("   To run scheduled flows, keep this process running or use Prefect workers.")
        print("\n   For production deployment with workers, use:")
        print("   prefect deploy --name ecommerce-etl-daily")

        # Create deployment without requiring image/storage
        ecommerce_etl_flow.serve(
            name="ecommerce-etl-daily",
            cron="0 2 * * *",  # Daily at 2 AM
            tags=["etl", "ecommerce", "dlt", "dbt"],
            description="Daily ETL pipeline for e-commerce data"
        )
    else:
        # Run flow immediately
        result = ecommerce_etl_flow()
        print("\n" + "="*60)
        print("Pipeline Result:")
        print(result)
        print("="*60)
