with source as (
    select p.id as product_id,
            p.product_code,
            p.product_name,
            p.description,
            s.company as supplier_company,
            p.standard_cost,
            p.list_price,
            p.reorder_level,
            p.target_level,
            p.quantity_per_unit,
            p.discontinued,
            p.minimum_reorder_quantity,
            p.category,
            p.attachments,
        current_timestamp() as insertion_timestamp
    from {{ ref('stg_product') }} as p
    left join {{ ref('stg_supplier') }} as s
    on p.supplier_id = s.id
),
unique_source as (
    select *,
           row_number() over(partition by product_id) as row_number
           from source
           --Allows deduplication
)

select *
except(row_number) --removes it row_number from the select query so it is not included in are data warehouse table
    from unique_source
        where row_number = 1 --Selects the first occurrence of the customer_id