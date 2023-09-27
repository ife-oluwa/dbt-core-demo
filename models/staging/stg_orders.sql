WITH source as ( SELECT * FROM {{ ref('raw_orders')}} ), 

renamed as (
    SELECT
        id as order_id,
        user_id as customer_id,
        order_date,
        status
    FROM source
)

SELECT * FROM renamed 