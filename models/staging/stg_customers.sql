select
    cast(customer_id as integer) as customer_id,
    cast(customer_name as varchar) as customer_name,
    cast(email as varchar) as email,
    cast(phone_number as varchar) as phone_number,
    cast(created_at as date) as created_at
from {{ ref('raw_customers') }}
