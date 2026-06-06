with order_records as (
    select
        order_id,
        customer_id,
        order_date,
        amount,
        status
    from {{ ref('stg_orders') }}
),

customer_records as (
    select
        customer_id,
        customer_name
    from {{ ref('stg_customers') }}
)

select
    order_records.order_id,
    order_records.customer_id,
    customer_records.customer_name,
    order_records.order_date,
    order_records.amount,
    order_records.status
from order_records
left join customer_records
    on order_records.customer_id = customer_records.customer_id
