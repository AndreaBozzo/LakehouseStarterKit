{{
    config(
        materialized='table'
    )
}}

with orders as (
    select * from {{ ref('stg_ecommerce__orders') }}
),

order_items as (
    select * from {{ ref('stg_ecommerce__order_items') }}
),

products as (
    select * from {{ ref('stg_ecommerce__products') }}
),

order_items_enriched as (
    select
        oi.order_id,
        oi.order_item_id,
        oi.product_id,
        p.product_name,
        p.category,
        oi.quantity,
        oi.unit_price,
        oi.subtotal
    from order_items oi
    left join products p on oi.product_id = p.product_id
),

order_items_agg as (
    select
        order_id,
        count(*) as total_items,
        sum(quantity) as total_quantity,
        sum(subtotal) as items_subtotal
    from order_items_enriched
    group by order_id
),

final as (
    select
        -- Order identifiers
        o.order_id,
        o.customer_id,

        -- Order details
        o.order_date,
        o.status,
        o.is_fulfilled,

        -- Financial metrics
        o.total_amount,
        o.discount_amount,
        o.shipping_cost,
        o.tax_amount,
        o.amount_after_discount,
        o.final_amount,

        -- Order items metrics
        coalesce(oia.total_items, 0) as total_items,
        coalesce(oia.total_quantity, 0) as total_quantity,
        coalesce(oia.items_subtotal, 0) as items_subtotal,

        -- Calculated metrics
        case
            when o.total_amount > 0 then (o.discount_amount / o.total_amount) * 100
            else 0
        end as discount_percentage,

        case
            when o.final_amount > 0 then o.shipping_cost / o.final_amount
            else 0
        end as shipping_cost_ratio

    from orders o
    left join order_items_agg oia on o.order_id = oia.order_id
)

select * from final
