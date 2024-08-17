-- noqa: dbt-opiner C001
{{
    config(
        unique_key="order_id",
    )
}}
with customers as (select customer_id, first_name, last_name from {{ ref("stg_customers") }})
select *
from customers
