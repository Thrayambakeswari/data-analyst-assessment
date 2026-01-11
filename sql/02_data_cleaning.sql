-- 02_data_cleaning.sql
-- Data cleaning and normalization
-- Clean views are created without modifying raw tables

-- Clean customers data
CREATE OR REPLACE VIEW customers_clean AS
SELECT
    customer_id,
    CASE
        WHEN signup_date LIKE '%-%-%' AND SUBSTRING(signup_date, 3, 1) = '-'
            THEN STR_TO_DATE(signup_date, '%d-%m-%Y')
        WHEN signup_date LIKE '%-%-%' AND SUBSTRING(signup_date, 5, 1) = '-'
            THEN STR_TO_DATE(signup_date, '%Y-%m-%d')
        ELSE NULL
    END AS signup_date,
    CASE
        WHEN segment IS NULL OR segment = '' THEN 'Unknown'
        ELSE segment
    END AS segment,
    country,
    is_enterprise
FROM customers;

-- Clean subscriptions data
CREATE OR REPLACE VIEW subscriptions_clean AS
SELECT
    subscription_id,
    customer_id,
    CASE
        WHEN start_date LIKE '%-%-%' AND SUBSTRING(start_date, 3, 1) = '-'
            THEN STR_TO_DATE(start_date, '%d-%m-%Y')
        WHEN start_date LIKE '%-%-%' AND SUBSTRING(start_date, 5, 1) = '-'
            THEN STR_TO_DATE(start_date, '%Y-%m-%d')
        ELSE NULL
    END AS start_date,
    CASE
        WHEN end_date IS NULL OR end_date = '' THEN NULL
        WHEN SUBSTRING(end_date, 3, 1) = '-'
            THEN STR_TO_DATE(end_date, '%d-%m-%Y')
        ELSE STR_TO_DATE(end_date, '%Y-%m-%d')
    END AS end_date,
    CAST(monthly_price AS UNSIGNED) AS monthly_price,
    status
FROM subscriptions;

-- Clean events data
CREATE OR REPLACE VIEW events_clean AS
SELECT
    customer_id,
    event_type,
    STR_TO_DATE(event_date, '%Y-%m-%d') AS event_date,
    source
FROM events;
