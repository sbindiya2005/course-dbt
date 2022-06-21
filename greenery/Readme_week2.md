What is our user repeat rate?

SELECT 
SUM(CASE WHEN repeats > 1 THEN 1 ELSE 0 END)/sum(count_users) as repeat_rate
FROM (SELECT user_id, count(order_id) as repeats, count(distinct user_id) as count_users
FROM orders
GROUP BY user_id
