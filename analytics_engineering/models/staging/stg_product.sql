with source as (

    select * from {{ source('northwind', 'product') }}
)

select *,
       current_timestamp() as ingestion_timestamp
from source