with orders as (
    select
        order_id,
        customer_id,
        order_date,
        amount,
        status
    from {{ ref('stg_orders') }}
),

customers as (
    select
        customer_id,
        customer_name
    from {{ ref('stg_customers') }}
)

select
    orders.order_id,
    orders.customer_id,
    customers.customer_name,
    orders.order_date,
    orders.amount,
    orders.status
from orders
left join customers
    on cast(orders.customer_id as integer) = customers.customer_id
