{{
  config(
    materialized='table'
  )
}}


SELECT
  product_id, 
  sum(CASE WHEN event_type = 'page_view' THEN 1 ELSE 0 END) as nb_page_views,
  sum(CASE WHEN event_type = 'add_to_cart' THEN 1 ELSE 0 END) as nb_add_to_carts,
  sum(CASE WHEN event_type = 'checkout' THEN 1 ELSE 0 END) as nb_checkout
FROM {{ ref('stg_greenery_events') }}
WHERE product_id IS NOT NULL
GROUP BY 1
