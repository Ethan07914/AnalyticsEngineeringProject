with source as (

    select * from {{ source('northwind', 'employee') }}
)

select *,
       current_timestamp() as ingestion_timestamp
from source