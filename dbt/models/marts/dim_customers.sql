{{
    config(
        materialized='table'
    )
}}

with customers as (
    select * from {{ ref('stg_ecommerce__customers') }}
),

orders as (
    select * from {{ ref('stg_ecommerce__orders') }}
),

customer_orders as (
    select
        customer_id,
        count(*) as total_orders,
        sum(final_amount) as lifetime_value,
        min(order_date) as first_order_date,
        max(order_date) as last_order_date,
        sum(case when is_fulfilled then 1 else 0 end) as fulfilled_orders,
        avg(final_amount) as avg_order_value
    from orders
    group by customer_id
),

final as (
    select
        c.customer_id,
        c.first_name,
        c.last_name,
        c.full_name,
        c.email,
        c.email_normalized,
        c.country,
        c.city,
        c.created_at as customer_since,

        -- Order metrics
        coalesce(co.total_orders, 0) as total_orders,
        coalesce(co.lifetime_value, 0) as lifetime_value,
        coalesce(co.avg_order_value, 0) as avg_order_value,
        co.first_order_date,
        co.last_order_date,
        coalesce(co.fulfilled_orders, 0) as fulfilled_orders,

        -- Customer segmentation
        case
            when coalesce(co.total_orders, 0) = 0 then 'Never Ordered'
            when co.total_orders = 1 then 'One-time Buyer'
            when co.total_orders between 2 and 5 then 'Repeat Buyer'
            when co.total_orders > 5 then 'Loyal Customer'
        end as customer_segment,

        case
            when coalesce(co.lifetime_value, 0) = 0 then 'No Value'
            when co.lifetime_value < 100 then 'Low Value'
            when co.lifetime_value between 100 and 500 then 'Medium Value'
            when co.lifetime_value > 500 then 'High Value'
        end as value_segment

    from customers c
    left join customer_orders co on c.customer_id = co.customer_id
)

select * from final
