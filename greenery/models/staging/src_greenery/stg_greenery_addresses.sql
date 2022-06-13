{{
  config(materialized='table')
}} 

select
    address_id as id,
    address as delivery_address,
    zipcode,
    state,
    country

from {{ source( 'greenery', 'addresses' ) }}


