{{
    config(MATERIALIZED='table')
}}

SELECT p.product_name,
    count(DISTINCT order_id) AS popular_product,
    sum(quantity) AS total_order_quantity
    From {{ref('greenery', 'stg_greenery_order_items')}} o
    LEFT JOIN {{ref('greenery','stg_greenery_products')}} p
    on p.product_id = o.product_id
    Group By p.product_name