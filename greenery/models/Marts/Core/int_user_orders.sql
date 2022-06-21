{{
    config(MATERIALIZED='Table')
}}

   select 
        orders.user_id
        , min(orders.created_at) as first_order
        , max(orders.created_at) as last_order
        , count(distinct orders.order_id) as total_orders_lifetime
        , count(distinct order_items.product_id) as unique_items_ordered
        , sum(orders.order_total) as total_spends_lifetime
        , avg(orders.order_total) as avg_order_cost_lifetime
        , sum(orders.order_total) / count(distinct orders.order_id)  as avg_order_spend_lifetime
        , extract(day from CURRENT_DATE::timestamp - MAX(orders.created_at::timestamp)) as days_since_last_order
        from orders
        left join order_items on order_items.order_id = orders.order_id
        group by 1