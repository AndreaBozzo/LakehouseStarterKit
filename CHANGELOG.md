# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.0.3] - 2025-10-26

### Added
- **Prefect Orchestration**: Complete workflow orchestration with scheduling
  - Flow: `flows/ecommerce_etl_flow.py` - End-to-end ETL pipeline
  - Deployment: `flows/deploy.py` - Deployment configuration
  - Docker service: Prefect Server on port 4200
  - 3 tasks: dlt ingestion → dbt transformation → dbt testing
  - Retry logic and error handling
  - Daily schedule at 2 AM (configurable)
  - Full logging and monitoring

- **Metabase Integration**: Business intelligence and visualization
  - Docker service: Metabase on port 3000
  - PostgreSQL metadata storage
  - DuckDB driver support
  - Volume mount for lakehouse.duckdb access
  - Setup guide: `docs/METABASE_SETUP.md`

- **Documentation**:
  - `docs/ORCHESTRATION.md` - Complete Prefect setup guide (400+ lines)
  - `docs/METABASE_SETUP.md` - Complete Metabase setup guide (500+ lines)
  - `docs/PROJECT_STATUS.md` - Detailed project status tracking

- **PostgreSQL Multi-database**:
  - `ecommerce` database: Source data (309 records)
  - `prefect` database: Orchestration metadata
  - `metabase` database: BI metadata
  - Init scripts: `postgres/init/00_databases.sql`

### Changed
- **PostgreSQL Port**: Changed from 15432 to 5433 for Windows compatibility
- **Architecture**: Added orchestration layer to the stack
  ```
  PostgreSQL → dlt → MinIO → dbt (DuckDB) → Metabase
                      ↓
                  Prefect (scheduling & monitoring)
  ```
- **requirements.txt**: Added Prefect 3.4+ and dependencies
- **.env.example**: Updated with Prefect and Metabase configuration
- **docker-compose.yml**: Added prefect-server and metabase services

### Fixed
- PostgreSQL healthcheck improved for faster startup detection
- Prefect Server healthcheck using Python urllib (curl not available)
- MinIO bucket permissions for public read access

### Technical Details
- **Prefect Version**: 3.4.25
- **Metabase Version**: latest (v0.50+)
- **Pipeline Duration**: ~4 minutes (249 seconds tested)
- **Data Quality**: 45/45 dbt tests passing
- **Services**: 4 Docker containers (all healthy)

## [0.0.2] - 2025-10-24

### Added
- Complete dbt transformation layer
  - 4 staging views: customers, products, orders, order_items
  - 3 mart tables: dim_customers, fct_orders, mart_sales_summary
  - 45 data quality tests (unique, not_null, relationships, accepted_values)
- dbt project configuration with DuckDB + S3/MinIO
- SQL models with full documentation and tests

### Changed
- Switched from Superset to Metabase for Windows compatibility
- dbt models now use S3-native approach via DuckDB httpfs extension

## [0.0.1] - 2025-10-22

### Added
- Initial project structure
- MinIO S3-compatible storage
- PostgreSQL source database with e-commerce sample data
- dlt pipeline: PostgreSQL → MinIO (Parquet format)
- Docker Compose setup with 2 services
- Basic documentation

---

## Roadmap

### v0.0.4 (Planned)
- [ ] Metabase dashboard templates
- [ ] Additional dbt models (incremental, snapshots)
- [ ] GitHub API pipeline migration to MinIO
- [ ] Data quality monitoring

### v0.1.0 (Planned)
- [ ] CI/CD with GitHub Actions
- [ ] Automated testing pipeline
- [ ] Production deployment guide
- [ ] Cloud S3 integration examples

### v1.0.0 (Future)
- [ ] Spark integration
- [ ] Apache Iceberg table format
- [ ] Multi-environment setup (dev/staging/prod)
- [ ] Advanced monitoring and alerting
