SELECT *
FROM {{ ref('stg_greenery_orders') }}
WHERE delivered_at < created_at 