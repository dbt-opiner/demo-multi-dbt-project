{{
    config(
        unique_key="customer_id",
    )
}}
with customers as (select customer_id, first_name, last_name from {{ ref("stg_customers") }})
select *
from customers
