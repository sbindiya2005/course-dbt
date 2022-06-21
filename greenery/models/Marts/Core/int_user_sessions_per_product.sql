{{
  config(materialized='table')
}}

select session_id , user_id, product_name,
 min(created_at) session_start,
 max(created_at) session_stop,
 count(distinct case when event_type = 'page_view' then 1  end ) page_view,
 count(distinct case when event_type = 'add_to_cart' then 1  end ) add_to_cart,
 count(distinct case when event_type = 'checkout' then 1 end ) checkout,
 count(distinct case when event_type = 'package_shipped' then 1 end ) package_shipped

FROM {{ ref('greenery', 'int_event_sessions') }} e

group by 1,2,3 