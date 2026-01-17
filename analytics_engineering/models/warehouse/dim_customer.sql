with source as (
    select id as customer_id,
        company,
        last_name,
        first_name,
        email_address,
        job_title,
        business_phone,
        home_phone,
        mobile_phone,
        fax_number,
        address,
        city,
        state_province,
        zip_postal_code,
        country_region,
        web_page,
        notes,
        attachments,
        current_timestamp() as insertion_timestamp
    from {{ ref('stg_customer') }}
),
unique_source as (
    select *,
           row_number() over(partition by customer_id) as row_number
           from source
           --Allows deduplication
)

select *
except(row_number) --removes it row_number from the select query so it is not included in are data warehouse table
    from unique_source
        where row_number = 1 --Selects the first occurrence of the customer_id