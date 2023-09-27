WITH source as ( SELECT * FROM {{ ref('raw_customers')}} ), 

renamed as (
    SELECT
        id as customer_id,
        first_name,
        last_name
    FROM source
)

SELECT * FROM renamed 