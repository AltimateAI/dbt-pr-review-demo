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
        customer_name,
        email
    from {{ ref('stg_customers') }}
)

select
    orders.order_id,
    orders.customer_id,
    customers.customer_name,
    orders.order_date,
    orders.amount,
    orders.status,
    md5(email) as email_hash
from orders
left join customers
    on orders.customer_id = customers.customer_id
