-- ============================================
-- Database Initialization for Lakehouse Services
-- ============================================
-- This script creates databases for:
-- - Metabase (BI tool metadata)
-- - Prefect (orchestration metadata)
-- ============================================

-- Create Metabase database (if not exists)
SELECT 'CREATE DATABASE metabase'
WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'metabase')\gexec

-- Create Prefect database (if not exists)
SELECT 'CREATE DATABASE prefect'
WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'prefect')\gexec

-- Grant privileges to postgres user
\c metabase
GRANT ALL PRIVILEGES ON DATABASE metabase TO postgres;

\c prefect
GRANT ALL PRIVILEGES ON DATABASE prefect TO postgres;

-- Return to default database
\c ecommerce
