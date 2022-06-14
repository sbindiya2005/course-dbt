1.How many users do we have?
[query]

SELECT COUNT(DISTINCT user_id) AS user_count
FROM users

2.On average, how many orders do we receive per hour?
[query]

WITH order_by_hour AS (
    SELECT date_part('hour',created_at) AS order_hour,
    COUNT(DISTINCT order_id) AS order_count
    FROM orders
    GROUP BY 1
)
SELECT COUNT(DISTINCT order_count)
FROM order_by_hour

3. On average, how long does an order take from being placed to being delivered?

WITH base AS (
    SELECT DATE_TRUNC('hour',created_at) AS Hour,
    COUNT(DISTINCT order_id) AS num_orders
    FROM dbt_bindiya_s.stg_greenery_orders
    GROUP BY 1
)
SELECT AVG(num_orders)
FROM base