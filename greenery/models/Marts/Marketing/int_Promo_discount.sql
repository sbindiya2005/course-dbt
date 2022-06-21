{{ config(
    materialized = 'view'
) }}

with user_promos_joined as (
    select distinct o.user_id, o.promo_id, p.promo_discount, p.promo_status, o.created_at
    from {{ ref('stg_greenery_orders') }} o 
    join {{ ref('stg_greenery_promos') }} p on o.promo_id = p.promo_id
    where promo_status = 'active'
) 
select user_id,
    count(promo_id) as active_code_count,
    sum(promo_discount) as absolute_discount,
    case when count(promo_id) > 0 then 'Y' else 'N' end as has_active_promo_code
from user_promos_joined
group by user_id 