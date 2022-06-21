{{  config(materialized='table')
}}

SELECT e.*, p.product_name
FROM {{ ref('greenery', 'stg_greenery_events') }} e 
left join {{ ref('greenery', 'stg_greenery_products') }} p
on p.product_id = e.product_id