{{
    config(
        materialized='view'
    )
}}

with source as (
    select * from read_parquet('s3://raw/ecommerce/ecommerce/customers/*.parquet')
),

renamed as (
    select
        customer_id,
        first_name,
        last_name,
        email,
        country,
        city,
        created_at,

        -- Derived fields
        first_name || ' ' || last_name as full_name,
        lower(email) as email_normalized

    from source
)

select * from renamed
