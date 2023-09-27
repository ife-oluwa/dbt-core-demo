WITH customers as (
        SELECT *
        FROM
{{ref('stg_customers')}}
    ),

orders as ( SELECT * FROM {{ref('stg_orders')}} ), 

payments as ( SELECT * FROM {{ref('stg_payments')}} ), 

customer_orders as (
    SELECT
        customer_id,
        min(order_date) as first_order,
        max(order_date) as most_recent_order,
        count(order_id) as number_of_orders
    FROM orders
    GROUP BY customer_id
),

customer_payments as (
    SELECT
        orders.customer_id,
        sum(amount) as total_amount
    FROM payments
        LEFT JOIN orders on payments.order_id = orders.order_id
    GROUP BY
        orders.customer_id
),

final as (
    SELECT
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order,
        customer_orders.most_recent_order,
        customer_orders.number_of_orders,
        customer_payments.total_amount as customer_lifetime_value
    FROM customers
        LEFT JOIN customer_orders ON customers.customer_id = customer_orders.customer_id
        LEFT JOIN customer_payments ON customers.customer_id = customer_payments.customer_id
)

SELECT * FROM final 