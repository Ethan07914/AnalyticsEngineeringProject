with source as (

    select * from {{ source('northwind', 'supplier') }}
)

select *,
       current_timestamp() as ingestion_timestamp
from source