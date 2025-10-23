{{
    config(
        materialized='table'
    )
}}

with orders as (
    select * from {{ ref('fct_orders') }}
),

order_items as (
    select * from {{ ref('stg_ecommerce__order_items') }}
),

products as (
    select * from {{ ref('stg_ecommerce__products') }}
),

customers as (
    select * from {{ ref('dim_customers') }}
),

-- Product-level sales
product_sales as (
    select
        p.product_id,
        p.product_name,
        p.category,
        count(distinct oi.order_id) as orders_count,
        sum(oi.quantity) as total_quantity_sold,
        sum(oi.subtotal) as total_revenue,
        avg(oi.unit_price) as avg_unit_price,
        max(oi.unit_price) as max_unit_price,
        min(oi.unit_price) as min_unit_price
    from order_items oi
    left join products p on oi.product_id = p.product_id
    group by p.product_id, p.product_name, p.category
),

-- Category-level sales
category_sales as (
    select
        category,
        count(*) as products_in_category,
        sum(total_quantity_sold) as category_quantity_sold,
        sum(total_revenue) as category_revenue,
        avg(avg_unit_price) as category_avg_price
    from product_sales
    group by category
),

-- Customer country sales
country_sales as (
    select
        c.country,
        count(distinct c.customer_id) as customers_count,
        count(distinct o.order_id) as orders_count,
        sum(o.final_amount) as total_revenue,
        avg(o.final_amount) as avg_order_value
    from orders o
    left join customers c on o.customer_id = c.customer_id
    group by c.country
),

-- Time-based sales (by date)
daily_sales as (
    select
        cast(order_date as date) as order_date,
        count(*) as orders_count,
        sum(final_amount) as daily_revenue,
        avg(final_amount) as avg_order_value,
        sum(total_items) as total_items_sold
    from orders
    group by cast(order_date as date)
),

-- Overall metrics
overall_metrics as (
    select
        'Overall' as metric_scope,
        count(distinct customer_id) as total_customers,
        count(*) as total_orders,
        sum(final_amount) as total_revenue,
        avg(final_amount) as avg_order_value,
        sum(total_items) as total_items,
        sum(discount_amount) as total_discounts,
        sum(shipping_cost) as total_shipping,
        sum(tax_amount) as total_tax
    from orders
)

-- Combine all metrics into a single summary table
select
    'product' as summary_type,
    product_name as dimension_value,
    category as sub_dimension,
    orders_count as metric_1,
    total_quantity_sold as metric_2,
    total_revenue as metric_3,
    avg_unit_price as metric_4
from product_sales

union all

select
    'category' as summary_type,
    category as dimension_value,
    null as sub_dimension,
    products_in_category as metric_1,
    category_quantity_sold as metric_2,
    category_revenue as metric_3,
    category_avg_price as metric_4
from category_sales

union all

select
    'country' as summary_type,
    country as dimension_value,
    null as sub_dimension,
    customers_count as metric_1,
    orders_count as metric_2,
    total_revenue as metric_3,
    avg_order_value as metric_4
from country_sales
