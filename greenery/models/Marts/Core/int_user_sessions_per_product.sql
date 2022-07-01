{{
  config(materialized='table')
}}

{% set event_types = dbt_utils.get_column_values(table=ref('stg_greenery_events'), column='event_type') %}

select session_id , user_id, product_name,
 min(created_at) session_start,
 max(created_at) session_stop,

 {% for event in event_types %}
		, count(1 ) filter( where event_type = '{{event}}') as {{event}}
 {% endfor %}

 --count(distinct case when event_type = 'page_view' then 1  end ) page_view,
 --count(distinct case when event_type = 'add_to_cart' then 1  end ) add_to_cart,
 --count(distinct case when event_type = 'checkout' then 1 end ) checkout,
 --count(distinct case when event_type = 'package_shipped' then 1 end ) package_shipped

FROM {{ ref('greenery', 'int_event_sessions') }} e

group by 1,2,3 