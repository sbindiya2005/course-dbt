{{
    config(MATERIALIZED='table')
}}

select
    promo_id,
    discount as promo_discount,
    status as promo_status

from {{ source( 'greenery', 'promos' ) }}
