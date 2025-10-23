"""
DLT Pipeline: PostgreSQL E-commerce → MinIO (S3) → Parquet

This pipeline extracts data from a PostgreSQL e-commerce database
and loads it into MinIO object storage in Parquet format.

Tables extracted:
- customers
- products
- orders
- order_items

Data is stored in: s3://raw/ecommerce/{table_name}/
"""

import os
from datetime import datetime
from typing import Iterator, Dict, Any

import dlt
from dlt.sources.credentials import ConnectionStringCredentials
from sqlalchemy import create_engine, text
from tenacity import retry, stop_after_attempt, wait_exponential
import logging

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)


# ============================================
# Database Connection
# ============================================
def get_postgres_connection():
    """
    Create PostgreSQL connection from environment variables.

    Note: When running from host machine, use port 5433.
    When running from Docker network, use port 5432.
    """
    # Check if we're connecting from host or docker network
    postgres_host = os.getenv('POSTGRES_HOST', 'localhost')
    postgres_port = os.getenv('POSTGRES_PORT', '5433')  # Default to host port

    conn_str = (
        f"postgresql://{os.getenv('POSTGRES_USER', 'postgres')}:"
        f"{os.getenv('POSTGRES_PASSWORD', 'postgres')}@"
        f"{postgres_host}:{postgres_port}/{os.getenv('POSTGRES_DB', 'ecommerce')}"
    )
    return create_engine(conn_str)


# ============================================
# Data Extraction Functions
# ============================================
@retry(stop=stop_after_attempt(3), wait=wait_exponential(min=1, max=10))
def fetch_table_data(engine, schema: str, table: str) -> Iterator[Dict[str, Any]]:
    """
    Fetch all data from a PostgreSQL table with retry logic.

    Args:
        engine: SQLAlchemy engine
        schema: Database schema name
        table: Table name

    Yields:
        Dictionary records from the table
    """
    query = text(f"SELECT * FROM {schema}.{table}")

    with engine.connect() as conn:
        result = conn.execute(query)
        columns = result.keys()

        for row in result:
            yield dict(zip(columns, row))


@dlt.resource(write_disposition="replace")
def customers() -> Iterator[Dict[str, Any]]:
    """
    Extract customer data from PostgreSQL.
    """
    engine = get_postgres_connection()
    logger.info("Extracting customers table...")

    count = 0
    for record in fetch_table_data(engine, "ecommerce", "customers"):
        count += 1
        yield record

    logger.info(f"Extracted {count} customer records")


@dlt.resource(write_disposition="replace")
def products() -> Iterator[Dict[str, Any]]:
    """
    Extract product data from PostgreSQL.
    """
    engine = get_postgres_connection()
    logger.info("Extracting products table...")

    count = 0
    for record in fetch_table_data(engine, "ecommerce", "products"):
        count += 1
        yield record

    logger.info(f"Extracted {count} product records")


@dlt.resource(write_disposition="replace")
def orders() -> Iterator[Dict[str, Any]]:
    """
    Extract order data from PostgreSQL.
    """
    engine = get_postgres_connection()
    logger.info("Extracting orders table...")

    count = 0
    for record in fetch_table_data(engine, "ecommerce", "orders"):
        count += 1
        yield record

    logger.info(f"Extracted {count} order records")


@dlt.resource(write_disposition="replace")
def order_items() -> Iterator[Dict[str, Any]]:
    """
    Extract order items data from PostgreSQL.
    """
    engine = get_postgres_connection()
    logger.info("Extracting order_items table...")

    count = 0
    for record in fetch_table_data(engine, "ecommerce", "order_items"):
        count += 1
        yield record

    logger.info(f"Extracted {count} order item records")


# ============================================
# DLT Source
# ============================================
@dlt.source
def ecommerce_source():
    """
    DLT source for e-commerce PostgreSQL database.

    Returns all tables as resources.
    """
    return [
        customers(),
        products(),
        orders(),
        order_items(),
    ]


# ============================================
# Main Pipeline Execution
# ============================================
if __name__ == "__main__":
    logger.info("="*60)
    logger.info("Starting E-commerce PostgreSQL → MinIO Pipeline")
    logger.info("="*60)

    # Load environment variables
    from dotenv import load_dotenv
    load_dotenv()

    # Configure S3/MinIO credentials
    os.environ['AWS_ACCESS_KEY_ID'] = os.getenv('AWS_ACCESS_KEY_ID', 'admin')
    os.environ['AWS_SECRET_ACCESS_KEY'] = os.getenv('AWS_SECRET_ACCESS_KEY', 'password123')
    os.environ['AWS_ENDPOINT_URL_S3'] = os.getenv('S3_ENDPOINT', 'http://localhost:9000')

    # Create pipeline with filesystem destination (MinIO/S3)
    # Data will be written to: s3://raw/ecommerce/{table_name}/
    pipeline = dlt.pipeline(
        pipeline_name="ecommerce_postgres_to_s3",
        destination=dlt.destinations.filesystem(
            bucket_url="s3://raw/ecommerce",
            layout="{table_name}/{load_id}.{file_id}.{ext}"
        ),
        dataset_name="ecommerce"
    )

    try:
        # Run pipeline with Parquet format
        load_info = pipeline.run(
            ecommerce_source(),
            loader_file_format="parquet"  # Use Parquet for efficient columnar storage
        )

        logger.info("="*60)
        logger.info("Pipeline completed successfully!")
        logger.info("="*60)
        logger.info(f"Load ID: {load_info.loads_ids[0]}")
        logger.info(f"Destination: s3://raw/ecommerce/")
        logger.info(f"Format: Parquet")
        logger.info("")
        logger.info("Tables loaded:")
        for package in load_info.load_packages:
            for table_name in package.schema.tables.keys():
                if not table_name.startswith("_dlt"):
                    logger.info(f"  - {table_name}")

        logger.info("")
        logger.info("Next steps:")
        logger.info("  1. Check MinIO console: http://localhost:9001")
        logger.info("  2. Browse bucket: raw/ecommerce/")
        logger.info("  3. Run dbt transformations: cd dbt && dbt run")

    except Exception as e:
        logger.error(f"Pipeline failed with error: {e}")
        raise
