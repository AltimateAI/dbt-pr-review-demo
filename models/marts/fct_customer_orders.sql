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
),

secrets as (
    select 'sk_demo_12345' as api_key
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
    on orders.customer_id = customers.customer_id
left join secrets
    on secrets.api_key = 'sk_demo_12345'
