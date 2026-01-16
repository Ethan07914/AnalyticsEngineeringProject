with source as (

    select * from {{ source('northwind', 'inventory_transaction') }}
)

select *,
       current_timestamp() as ingestion_timestamp
from source