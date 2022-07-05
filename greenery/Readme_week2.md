What is our user repeat rate?

with user_order_count as (
select user_id, count(distinct order_id)as num_order
from dbt_bindiya_s.dim_orders
group by 1
order by 2 desc)
select sum(case when num_order>1 then 1 else 0 end),
sum(1),
sum(case when num_order>1 then 1 else 0 end)/sum(1)
from user_order_count;

