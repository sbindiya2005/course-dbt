{{
    config(materialized='table')
    }}
select o.order_id , o.user_id , 
	promo_id , address_id, created_at , shipping_service , status 
from {{ref('stg_greenery_orders')}} o