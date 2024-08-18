with customers as (select customer_id, first_name, last_name from {{ ref("stg_customers") }})
select *
from customers
