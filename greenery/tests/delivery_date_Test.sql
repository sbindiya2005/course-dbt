SELECT *
FROM {{ ref('stg_greenery_orders') }}
WHERE order_delivered_at_utc < order_created_at_utc 