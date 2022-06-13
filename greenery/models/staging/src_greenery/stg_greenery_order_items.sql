{{
    config(MATERIALIZED='table')
}}

select
    order_id as id,
    product_id, 
    quantity

from {{ source( 'greenery', 'order_items' ) }}
