{{
  config(materialized='table')
}}
select session_id , user_id, product_name,
  min(created_at) session_start,
  max(created_at) session_stop,
  count(distinct case when event_type = 'page_view' then 1 else 0 end )as nb_page_view,
  count(distinct case when event_type = 'add_to_cart' then 1 else 0  end )as nb_add_to_cart,
  count(distinct case when event_type = 'checkout' then 1 else 0 end )as  nb_checkout,
  count(distinct case when event_type = 'package_shipped' then 1 end )as nb_package_shipped

from dbt_bindiya_s.int_event_sessions
group by 1,2,3 