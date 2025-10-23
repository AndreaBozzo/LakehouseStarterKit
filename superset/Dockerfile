FROM apache/superset:latest

# Switch to root to install packages
USER root

# Install DuckDB driver and PostgreSQL connector
# Also install flask-cors which may be missing in some superset versions
RUN pip install --no-cache-dir \
    duckdb-engine>=0.11.0 \
    psycopg2-binary>=2.9.0 \
    duckdb>=1.0.0 \
    flask-cors>=3.0.0

# Switch back to superset user for security
USER superset

# Set healthcheck
HEALTHCHECK --interval=30s --timeout=10s --retries=5 \
    CMD curl -f http://localhost:8088/health || exit 1
