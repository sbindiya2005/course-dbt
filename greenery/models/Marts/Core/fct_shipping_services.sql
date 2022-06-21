{{
  config(Materialized='table')
}}

select shipping_service,
 count(*) orders_done,
 sum(order_total) order_total,
 sum(shipping_cost) shipping_costs

from {{ ref('greenery', 'stg_greenery_orders') }}

group by 1
order by 2 desc 