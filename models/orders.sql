{%
set
    payment_methods = ['credit_card',
    'coupon',
    'bank_transfer',
    'gift_vard'] %}

WITH orders as ( SELECT * FROM {{ ref('stg_orders') }} ), 

payments as ( SELECT * FROM {{ ref('stg_payments') }} ), 

order_payments as (
    SELECT
        order_id,
{% for payment_method in payment_methods -%}
SUM(
            case
                WHEN payment_method = '{{ payment_method }}' then amount
                else 0
            end
        ) as {{payment_method}}_amount,
{% endfor -%}
SUM(amount) as total_amount
    FROM payments
    GROUP BY order_id
),

final as (
    SELECT
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        orders.status,
        {%for payment_method in payment_methods -%}
        order_payments.{{ payment_method }}_amount,
        {%endfor -%}
        order_payments.total_amount as amount
    FROM orders
    LEFT JOIN order_payments
    ON orders.order_id = order_payments.order_id
)

SELECT * FROM final