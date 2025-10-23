{{
    config(
        materialized='view'
    )
}}

with source as (
    select * from read_parquet('s3://raw/ecommerce/ecommerce/orders/*.parquet')
),

renamed as (
    select
        order_id,
        customer_id,
        order_date,
        order_status as status,
        total_amount,
        discount_amount,
        shipping_cost,
        tax_amount,

        -- Derived fields
        total_amount - discount_amount as amount_after_discount,
        (total_amount - discount_amount) + shipping_cost + tax_amount as final_amount,
        case
            when order_status in ('delivered', 'shipped') then true
            else false
        end as is_fulfilled

    from source
)

select * from renamed
