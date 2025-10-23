"""
Superset Configuration for Lakehouse Starter Kit
"""
import os

# Security Configuration
# IMPORTANT: Use environment variable for production deployments
SECRET_KEY = os.environ.get("SUPERSET_SECRET_KEY", "supersecretkey")

# Database Configuration
SQLALCHEMY_DATABASE_URI = "sqlite:///superset_home/superset.db"

# Performance Settings
ROW_LIMIT = 5000
RESULTS_BACKEND = None  # Optional: Configure Redis for caching

# CORS Configuration
# Disabled for now - can be enabled later if needed
# ENABLE_CORS = True
# CORS_OPTIONS = {
#     'supports_credentials': True,
#     'origins': ['http://localhost:8088', 'http://127.0.0.1:8088']
# }

# Feature Flags
FEATURE_FLAGS = {
    "ENABLE_TEMPLATE_PROCESSING": True,
    "DASHBOARD_NATIVE_FILTERS": True,
    "DASHBOARD_CROSS_FILTERS": True,
}

# DuckDB Connection Configuration
# Enable SQL Lab for ad-hoc queries
SQLLAB_ASYNC_TIME_LIMIT_SEC = 300
SQLLAB_TIMEOUT = 300

# Logging
import logging
LOG_LEVEL = logging.INFO
ENABLE_TIME_ROTATE = True
