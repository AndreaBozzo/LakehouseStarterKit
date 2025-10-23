{{
    config(
        materialized='view'
    )
}}

with source as (
    select * from read_parquet('s3://raw/ecommerce/ecommerce/products/*.parquet')
),

renamed as (
    select
        product_id,
        product_name,
        category,
        price,
        stock_quantity,
        created_at,

        -- Derived fields
        case
            when stock_quantity = 0 then 'Out of Stock'
            when stock_quantity < 10 then 'Low Stock'
            else 'In Stock'
        end as stock_status

    from source
)

select * from renamed
