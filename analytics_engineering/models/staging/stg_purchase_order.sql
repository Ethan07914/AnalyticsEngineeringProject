with source as (

    select * from {{ source('northwind', 'purchase_order') }}
)

select *,
       current_timestamp() as ingestion_timestamp
from source