with source as (

    select * from {{ source('northwind', 'string') }}
)

select *,
       current_timestamp() as ingestion_timestamp
from source