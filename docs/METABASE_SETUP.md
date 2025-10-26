# 📊 Metabase Setup Guide

This guide walks you through setting up Metabase for data visualization and creating dashboards for e-commerce analytics.

## Overview

**Metabase** is an open-source business intelligence tool that provides:

- **Easy-to-use interface** for creating charts and dashboards
- **SQL query builder** with visual editor
- **DuckDB support** for querying data lake files
- **Automatic question suggestions** based on your data
- **Sharing & embedding** dashboards

## Architecture

```text
Metabase (http://localhost:3000)
    ↓
DuckDB (lakehouse.duckdb)
    ↓
Analytics Tables:
  - dim_customers (customer dimension)
  - fct_orders (orders fact table)
  - mart_sales_summary (aggregated sales)
  - 4 staging views (raw data)
```

## Getting Started

### Step 1: Access Metabase

1. **Start Docker services**:
   ```bash
   docker-compose up -d
   ```

2. **Wait for initialization** (5-10 minutes on first startup):
   ```bash
   # Check Metabase status
   docker logs metabase -f

   # When ready, you'll see:
   # Metabase Initialization COMPLETE
   ```

3. **Open Metabase UI**:
   - URL: http://localhost:3000
   - First visit will show setup wizard

### Step 2: Initial Setup (First Time Only)

On your first visit, complete the setup wizard:

#### 2.1 Welcome Screen
- Language: Select **English** (or your preference)
- Click **Let's get started**

#### 2.2 Create Admin Account
- **First name**: Your name
- **Last name**: Your surname
- **Email**: admin@localhost (or your email)
- **Password**: Choose a secure password
- Click **Next**

**Important**: Save these credentials securely!

#### 2.3 Add Your Data

This is where we connect to DuckDB:

**Option A: Skip for Now** (Recommended)
- Click **I'll add my data later**
- We'll configure manually for better control

**Option B: Configure Now**
- Database type: **DuckDB** (if available in dropdown)
- If DuckDB is not listed, skip and configure manually (see Step 3)

#### 2.4 Data Preferences
- **Allow Metabase to anonymously collect usage events**: Your choice
- Click **Next**

#### 2.5 Complete Setup
- Click **Take me to Metabase**

### Step 3: Connect to DuckDB Database

#### 3.1 Navigate to Admin Panel

1. Click your **profile icon** (top right)
2. Select **Admin settings**
3. Click **Databases** tab
4. Click **Add database**

#### 3.2 Configure DuckDB Connection

**Database Type**: Select **DuckDB** from dropdown

If DuckDB is not available, you have two options:

**Option A: Use DuckDB Driver (Recommended)**
- Metabase may not have native DuckDB support by default
- Install DuckDB driver plugin:
  ```bash
  # Download DuckDB Metabase driver
  # Place .jar file in metabase_data/plugins/ directory
  # Restart Metabase container
  ```

**Option B: Use PostgreSQL Foreign Data Wrapper**
- Connect DuckDB to PostgreSQL via FDW
- Query DuckDB tables through PostgreSQL connection
- More complex setup (not recommended for this starter kit)

**For this guide, we'll use a workaround:**

#### 3.3 Alternative: SQLite Connection (Workaround)

Since DuckDB driver may not be available by default, we can:

1. **Export DuckDB data to SQLite** (temporary solution):
   ```bash
   # In project root
   python -c "
   import duckdb
   import sqlite3

   # Read from DuckDB
   duck = duckdb.connect('lakehouse.duckdb', read_only=True)

   # Export to SQLite
   sqlite = sqlite3.connect('lakehouse.sqlite')

   # Export each table
   for table in ['dim_customers', 'fct_orders', 'mart_sales_summary']:
       df = duck.execute(f'SELECT * FROM {table}').df()
       df.to_sql(table, sqlite, if_exists='replace', index=False)

   duck.close()
   sqlite.close()
   print('✅ Exported to lakehouse.sqlite')
   "
   ```

2. **Connect Metabase to SQLite**:
   - Database type: **SQLite**
   - Name: `Lakehouse Analytics`
   - File path: `/duckdb/lakehouse.sqlite` (Docker path)
   - Click **Save**

**Note**: This is a temporary workaround. For production, use the DuckDB Metabase driver or PostgreSQL with DuckDB FDW.

### Step 4: Verify Database Connection

1. After saving, Metabase will test the connection
2. Status should show **Connected** (green)
3. Click **Exit admin**
4. You should see the database in the home screen

### Step 5: Explore Your Data

#### 5.1 Browse Tables

1. From home screen, click **Lakehouse Analytics** (your database)
2. You'll see available tables:
   - `dim_customers` - Customer dimension
   - `fct_orders` - Orders fact table
   - `mart_sales_summary` - Sales aggregations

3. Click any table to preview data

#### 5.2 Run a Simple Query

1. Click **New** → **Question**
2. Select **Simple question**
3. Choose **Lakehouse Analytics** → `fct_orders`
4. Click **Visualize**
5. You'll see the orders table

## Creating Dashboards

### Dashboard 1: Sales Overview

#### Create the Dashboard

1. Click **New** → **Dashboard**
2. Name: `Sales Overview`
3. Description: `Overall sales performance and trends`
4. Click **Create**

#### Add Questions (Charts)

**Question 1: Total Revenue**

1. Click **New question** → **Simple question**
2. Data: `fct_orders`
3. Summarize: **Sum of** `final_amount`
4. Visualization: **Number**
5. Save as: `Total Revenue`
6. Add to dashboard: `Sales Overview`

**Question 2: Total Orders**

1. New question → Simple question
2. Data: `fct_orders`
3. Summarize: **Count**
4. Visualization: **Number**
5. Save as: `Total Orders`
6. Add to dashboard: `Sales Overview`

**Question 3: Average Order Value**

1. New question → Simple question
2. Data: `fct_orders`
3. Summarize: **Average of** `final_amount`
4. Visualization: **Number**
5. Save as: `Average Order Value`
6. Add to dashboard: `Sales Overview`

**Question 4: Revenue Over Time**

1. New question → Simple question
2. Data: `fct_orders`
3. Summarize: **Sum of** `final_amount`
4. Group by: `order_date` (by **Month**)
5. Visualization: **Line chart**
6. Settings:
   - X-axis: `order_date`
   - Y-axis: `Sum of final_amount`
7. Save as: `Revenue Trend`
8. Add to dashboard: `Sales Overview`

**Question 5: Orders by Status**

1. New question → Simple question
2. Data: `fct_orders`
3. Summarize: **Count**
4. Group by: `status`
5. Visualization: **Pie chart**
6. Save as: `Orders by Status`
7. Add to dashboard: `Sales Overview`

**Question 6: Top 10 Customers by Revenue**

1. New question → Simple question
2. Data: `dim_customers`
3. Summarize: **Sum of** `lifetime_value`
4. Group by: `full_name`
5. Sort: **Sum of lifetime_value** descending
6. Limit: **10 rows**
7. Visualization: **Bar chart**
8. Save as: `Top 10 Customers`
9. Add to dashboard: `Sales Overview`

### Dashboard 2: Customer Analytics

#### Create the Dashboard

1. New → Dashboard
2. Name: `Customer Analytics`
3. Description: `Customer segmentation and behavior analysis`

#### Add Questions

**Question 1: Customers by Segment**

1. New question → Simple question
2. Data: `dim_customers`
3. Summarize: **Count**
4. Group by: `customer_segment`
5. Visualization: **Bar chart**
6. Save as: `Customers by Segment`
7. Add to dashboard: `Customer Analytics`

**Question 2: Lifetime Value Distribution**

1. New question → Simple question
2. Data: `dim_customers`
3. Summarize: **Count**
4. Group by: `value_segment`
5. Visualization: **Donut chart**
6. Save as: `LTV Distribution`
7. Add to dashboard: `Customer Analytics`

**Question 3: Average Orders per Customer**

1. New question → Simple question
2. Data: `dim_customers`
3. Summarize: **Average of** `total_orders`
4. Visualization: **Number**
5. Save as: `Avg Orders per Customer`
6. Add to dashboard: `Customer Analytics`

**Question 4: Customer Lifetime Value Stats**

1. New question → Simple question
2. Data: `dim_customers`
3. Multiple summarizations:
   - Min of `lifetime_value`
   - Average of `lifetime_value`
   - Max of `lifetime_value`
4. Visualization: **Table**
5. Save as: `LTV Statistics`
6. Add to dashboard: `Customer Analytics`

### Dashboard 3: Product Performance

#### Create the Dashboard

1. New → Dashboard
2. Name: `Product Performance`
3. Description: `Product and category sales analysis`

#### Add Questions

**Question 1: Sales by Category** (using Native Query)

1. New question → **Native query**
2. Database: `Lakehouse Analytics`
3. Query:
   ```sql
   SELECT
     dimension_value AS category,
     metric_1 AS total_revenue,
     metric_2 AS total_orders
   FROM mart_sales_summary
   WHERE summary_type = 'category'
   ORDER BY total_revenue DESC
   ```
4. Visualization: **Bar chart**
5. Save as: `Sales by Category`
6. Add to dashboard: `Product Performance`

**Question 2: Top 10 Products** (using Native Query)

1. New question → Native query
2. Query:
   ```sql
   SELECT
     dimension_value AS product_name,
     metric_1 AS total_revenue,
     metric_2 AS total_quantity_sold
   FROM mart_sales_summary
   WHERE summary_type = 'product'
   ORDER BY total_revenue DESC
   LIMIT 10
   ```
3. Visualization: **Table** or **Bar chart**
4. Save as: `Top 10 Products`
5. Add to dashboard: `Product Performance`

**Question 3: Sales by Country**

1. New question → Native query
2. Query:
   ```sql
   SELECT
     dimension_value AS country,
     metric_1 AS total_revenue,
     metric_2 AS total_orders
   FROM mart_sales_summary
   WHERE summary_type = 'country'
   ORDER BY total_revenue DESC
   ```
3. Visualization: **Bar chart** or **Map** (if country codes available)
4. Save as: `Sales by Country`
5. Add to dashboard: `Product Performance`

## Dashboard Layout Tips

### Organizing Your Dashboard

1. **Open dashboard** in edit mode
2. **Drag and drop** questions to reposition
3. **Resize** by dragging corners
4. **Recommended layout**:
   - **Top row**: Key metrics (numbers) - 3-4 columns
   - **Middle rows**: Charts (trends, distributions) - 2 columns
   - **Bottom rows**: Tables (detailed data) - full width

### Adding Text Cards

1. In dashboard edit mode, click **Add a text card**
2. Use for:
   - Dashboard title and description
   - Section headers (e.g., "Revenue Metrics", "Customer Insights")
   - Notes and context

Example:
```markdown
# Sales Overview

This dashboard provides a comprehensive view of sales performance, including:
- Total revenue and order counts
- Revenue trends over time
- Order status distribution
- Top performing customers
```

### Dashboard Filters

Add filters for interactive exploration:

1. Dashboard edit mode → **Add a filter**
2. **Date filter**:
   - Variable type: **Date**
   - Connect to: All questions with `order_date` field
   - Default: **Past 30 days**
3. **Status filter**:
   - Variable type: **Text/Category**
   - Connect to: Questions with `status` field
   - Values: delivered, shipped, processing, pending, cancelled

## Sharing & Embedding

### Share Dashboard Link

1. Open dashboard
2. Click **Share** (top right)
3. **Copy link** or **Enable public sharing**
4. Public links allow viewing without login

### Schedule Email Reports

1. Open dashboard
2. Click **Share** → **Send via email**
3. Configure:
   - Recipients: email addresses
   - Schedule: Daily, Weekly, Monthly
   - Time: Choose preferred time
4. Click **Send**

### Embed Dashboard

1. Admin settings → **Embedding**
2. Enable embedding
3. Copy embed code for dashboards
4. Use in internal wikis, portals, etc.

## Advanced Features

### Custom Questions with SQL

For complex queries, use **Native Query**:

**Example: Monthly Revenue Growth**

```sql
WITH monthly_revenue AS (
  SELECT
    DATE_TRUNC('month', order_date) AS month,
    SUM(final_amount) AS revenue
  FROM fct_orders
  WHERE status = 'delivered'
  GROUP BY month
)
SELECT
  month,
  revenue,
  revenue - LAG(revenue) OVER (ORDER BY month) AS revenue_growth,
  ROUND(100.0 * (revenue - LAG(revenue) OVER (ORDER BY month)) / LAG(revenue) OVER (ORDER BY month), 2) AS growth_pct
FROM monthly_revenue
ORDER BY month DESC
```

### Alerts

Set up alerts for key metrics:

1. Open a question (e.g., "Total Revenue")
2. Click **Watch this** (bell icon)
3. Configure:
   - Condition: e.g., "Goes above 100000"
   - Frequency: Check every hour/day
   - Recipients: Email addresses
4. Save alert

### Collections

Organize related dashboards and questions:

1. **Create collection**: New → Collection
2. Name: e.g., "E-commerce Analytics"
3. **Move items**: Drag dashboards and questions into collection
4. **Share collection**: Give team access

## Troubleshooting

### Metabase Not Loading

**Issue**: http://localhost:3000 doesn't load

**Solution**:
```bash
# Check container status
docker ps | grep metabase

# Check logs
docker logs metabase -f

# Wait for initialization (5-10 minutes first time)
# Look for: "Metabase Initialization COMPLETE"

# Restart if needed
docker-compose restart metabase
```

### Database Connection Failed

**Issue**: "Unable to connect to database"

**Solution**:
```bash
# Verify DuckDB file exists
ls -lh lakehouse.duckdb

# Check file is mounted in container
docker exec -it metabase ls -lh /duckdb/

# Verify DuckDB file has data
duckdb lakehouse.duckdb -c "SHOW TABLES;"

# Expected output: dim_customers, fct_orders, mart_sales_summary, staging views
```

### No Tables Visible

**Issue**: Database connected but no tables show up

**Solution**:
```bash
# Run dbt to create tables
cd dbt
dbt run --profiles-dir .

# Verify tables in DuckDB
duckdb ../lakehouse.duckdb -c "SHOW TABLES;"

# Sync Metabase schema
# Admin → Databases → Lakehouse Analytics → "Sync database schema now"
```

### Question Returns No Data

**Issue**: Chart shows "No results"

**Solution**:
```bash
# Verify data exists in source table
duckdb lakehouse.duckdb -c "SELECT COUNT(*) FROM fct_orders;"

# Run dlt pipeline to load data
python dlt/pipelines/ecommerce_postgres.py

# Run dbt to transform
cd dbt && dbt run

# Refresh Metabase question
```

## Best Practices

### Performance Optimization

1. **Use aggregated tables**: Query `mart_sales_summary` instead of joining raw tables
2. **Limit result sets**: Use LIMIT in SQL queries for large tables
3. **Cache results**: Metabase caches question results for 24 hours by default
4. **Schedule refreshes**: For expensive queries, schedule to run off-peak

### Dashboard Design

1. **Keep it simple**: 6-8 visualizations per dashboard max
2. **Use consistent colors**: Configure theme in Admin settings
3. **Add context**: Use text cards to explain metrics
4. **Mobile-friendly**: Test dashboards on smaller screens

### Data Governance

1. **Use collections**: Organize by team or use case
2. **Set permissions**: Control who can view/edit
3. **Document queries**: Add descriptions to questions
4. **Version control**: Export dashboards as JSON for backup

## Resources

- **Metabase Docs**: https://www.metabase.com/docs/latest/
- **Metabase UI**: http://localhost:3000
- **DuckDB Tables**: [dbt/models/marts/](../dbt/models/marts/)
- **Sample Queries**: See "Custom Questions with SQL" section above

## Next Steps

1. ✅ Create all 3 dashboards (Sales, Customers, Products)
2. ✅ Add filters for interactive exploration
3. ⏭️ Schedule daily email reports
4. ⏭️ Set up alerts for key metrics
5. ⏭️ Share dashboards with team

---

**Last Updated**: 2025-10-26
**Version**: 0.0.3
