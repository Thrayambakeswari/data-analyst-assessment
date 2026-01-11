-- 01_table_creation.sql
-- Raw table creation for customers, subscriptions, and events
-- All columns are initially stored as TEXT to avoid parsing issues

CREATE TABLE customers (
    customer_id TEXT,
    signup_date TEXT,
    segment TEXT,
    country TEXT,
    is_enterprise TEXT
);

CREATE TABLE subscriptions (
    subscription_id TEXT,
    customer_id TEXT,
    start_date TEXT,
    end_date TEXT,
    monthly_price TEXT,
    status TEXT
);

CREATE TABLE events (
    event_id TEXT,
    customer_id TEXT,
    event_type TEXT,
    event_date TEXT,
    source TEXT
);
