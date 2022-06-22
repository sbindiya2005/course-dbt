{{
    config(MATERIALIZED='table')
}}

SELECT
  U.user_id,
  U.first_name,
  U.last_name,
  U.email,
  U.phone_number,
  U.address_id,
  A.address,
  A.state,
  A.country,
  A.zipcode
FROM {{ref('stg_greenery_users')}} as U
LEFT JOIN {{ref('stg_greenery_addresses')}} as A 
  ON U.address_id = A.address_id
  