with source as (

    select
        cast(supplier_ids as integer) as supplier_id,
        --Ensure all ids can be casted as an integer to ensure not columns which contain errors are added to the model
        id,
        product_code,
        product_name,
        description,
        standard_cost,
        list_price,
        reorder_level,
        target_level,
        quantity_per_unit,
        discontinued,
        minimum_reorder_quantity,
        category,
        attachments
        from {{ source('northwind', 'product') }}
        where supplier_ids not like '%;%' --Rows at contain colons in ids are errors
)

select *,
       current_timestamp() as ingestion_timestamp
from source