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
    metrics.customer_order_count,
    orders.status
from orders
left join customers
    on orders.customer_id = customers.customer_id
left join lateral (
    select count(*) as customer_order_count
    from {{ ref('stg_orders') }} as order_metrics
    where order_metrics.customer_id = orders.customer_id
) as metrics on true
