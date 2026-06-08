select
    cast(customer_id as integer) as customer_id,
    cast(customer_name as varchar) as customer_name,
    cast(email as varchar) as email,
    cast(ssn as varchar) as ssn,
    cast(created_at as date) as created_at
from {{ ref('raw_customers') }}
