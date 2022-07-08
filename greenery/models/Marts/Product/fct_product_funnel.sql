{{
  config(
    materialized='incremental',
    )
}}

with session_counts as(
    select session_id,
        max(case when event_type='page_view' then 1.0 else 0 end) as pv,
        max(case when event_type='add_to_cart' then 1.0 else 0 end) as atc,
        max(case when event_type='checkout' then 1.0 else 0 end) as ckt
    from dbt_bindiya_s.int_event_sessions
    group by session_id
)
    select  round((sum(pv)::numeric / count(session_id)),2)*100 as page_views_pct,
            round((sum(atc)::numeric / sum(pv)::numeric),2)*100 as add_to_cart_pct,
            round((sum(ckt)::numeric / (select sum(atc))::numeric),2)*100 as checkout_pct
    from session_counts


    
