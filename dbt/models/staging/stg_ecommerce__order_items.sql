{{
    config(
        materialized='view'
    )
}}

with source as (
    select * from read_parquet('s3://raw/ecommerce/ecommerce/order_items/*.parquet')
),

renamed as (
    select
        order_item_id,
        order_id,
        product_id,
        quantity,
        unit_price,
        total_price as subtotal,

        -- Derived fields
        case
            when total_price != (quantity * unit_price) then true
            else false
        end as has_price_discrepancy

    from source
)

select * from renamed
