with session_counts as(
    select session_id,
        max(case when event_type='page_view' then 1.0 else 0 end) as pv,
        max(case when event_type='add_to_cart' then 1.0 else 0 end) as atc,
        max(case when event_type='checkout' then 1.0 else 0 end) as ckt
    from dbt_bindiya_s.int_event_sessions
    group by session_id
),
session_product as(
    select session_id,product_id,
        max(case when event_type='page_view' then 1.0 else 0 end) as pv,
        max(case when event_type='add_to_cart' then 1.0 else 0 end) as atc
    from dbt_bindiya_s.int_event_sessions
    group by session_id,product_id
)
select sum(session_product.atc)/sum(session_counts.ckt) as overall_conversion_rate
from session_counts
left join session_product on session_counts.session_id=session_product.session_id

