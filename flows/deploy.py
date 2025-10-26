"""
Prefect Deployment Script

This script deploys the e-commerce ETL flow to Prefect Server
with a daily schedule.

Usage:
    python flows/deploy.py
"""

import os
import sys
from pathlib import Path

# Add project root to path
PROJECT_ROOT = Path(__file__).parent.parent
sys.path.insert(0, str(PROJECT_ROOT))

from prefect import serve
from flows.ecommerce_etl_flow import ecommerce_etl_flow


def main():
    """
    Deploy the e-commerce ETL flow to Prefect Server.
    """
    print("="*60)
    print("Deploying E-commerce ETL Flow to Prefect Server")
    print("="*60)

    # Load environment variables
    from dotenv import load_dotenv
    load_dotenv(PROJECT_ROOT / ".env")

    # Verify Prefect API connection
    prefect_api_url = os.getenv("PREFECT_API_URL", "http://localhost:4200/api")
    print(f"Prefect API URL: {prefect_api_url}")

    # Create deployment with schedule
    deployment = ecommerce_etl_flow.to_deployment(
        name="ecommerce-etl-daily",
        cron="0 2 * * *",  # Daily at 2 AM
        tags=["etl", "ecommerce", "dlt", "dbt", "production"],
        description="Daily ETL pipeline for e-commerce data: PostgreSQL → MinIO → dbt",
        version="1.0.0",
    )

    print("\n✅ Deployment configuration created:")
    print(f"   Name: {deployment.name}")
    print(f"   Schedule: Daily at 02:00 AM")
    print(f"   Tags: {deployment.tags}")

    # Serve the deployment
    print("\n🚀 Starting deployment server...")
    print("   Press Ctrl+C to stop")
    print(f"   UI: http://localhost:4200")
    print("="*60 + "\n")

    serve(deployment)


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\n\n✅ Deployment server stopped")
        sys.exit(0)
    except Exception as e:
        print(f"\n\n❌ Deployment failed: {e}")
        sys.exit(1)
