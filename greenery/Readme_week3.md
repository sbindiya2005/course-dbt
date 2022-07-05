What is our overall conversion rate?

Check conversion rate SQL in marts/core/fct_conversion_rate.sql

{% set event_types=dbt_utils.get_column_values(table='ref('stg_greenery_events')', column='event_type') %}

  for session_id,
    
    {% for event in event_types %}
    
      ,max(case when event_type = '{{event}}' then 1 else 0 end) as {{event}}_present
      
    {% endfor %}

    /*
        max(case when event_type='page_view' then 1.0 else 0 end) as pv,
        max(case when event_type='add_to_cart' then 1.0 else 0 end) as atc,
        max(case when event_type='checkout' then 1.0 else 0 end) as ckt
    */
    
    from {{ref('int_event_sessions')}}
    group by session_id;
