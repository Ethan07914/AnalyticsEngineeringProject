with source as (

    select * from {{ source('northwind', 'shipper') }}
)

select *,
       current_timestamp() as ingestion_timestamp
from source