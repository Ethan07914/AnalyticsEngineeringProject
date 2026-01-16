with source as (

    select * from {{ source('northwind', 'order_detail_status') }}
)

select *,
       current_timestamp() as ingestion_timestamp
from source