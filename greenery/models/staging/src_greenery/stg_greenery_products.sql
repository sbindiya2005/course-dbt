{{
    config(MATERIALIZED='table')
}}

select
    product_id,
    name as product_name,
    price,
    inventory

from {{ source( 'greenery', 'products' ) }}
