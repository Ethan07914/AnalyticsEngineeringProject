with source as (

    select * from {{ source('northwind', 'order_detail_status') }}
)

select * from source