with source as (

    select * from {{ source('northwind', 'invoice') }}
)

select *,
       current_timestamp() as ingestion_timestamp
from source