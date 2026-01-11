-- 04_funnel_analysis.sql
-- Funnel Analysis: Signup → Trial → Activated → Paid → Churned
-- Trial stage uses `trial_start` based on events_clean data

WITH funnel_events AS (
    SELECT
        customer_id,
        MAX(CASE WHEN event_type = 'signup' THEN 1 ELSE 0 END) AS signup,
        MAX(CASE WHEN event_type = 'trial_start' THEN 1 ELSE 0 END) AS trial,
        MAX(CASE WHEN event_type = 'activated' THEN 1 ELSE 0 END) AS activated
    FROM events_clean
    GROUP BY customer_id
),
paid_customers AS (
    SELECT DISTINCT customer_id
    FROM subscriptions_clean
),
churned_customers AS (
    SELECT DISTINCT customer_id
    FROM subscriptions_clean
    WHERE end_date IS NOT NULL
)
SELECT
    COUNT(DISTINCT f.customer_id) AS total_customers,
    SUM(f.signup) AS signup_users,
    SUM(CASE WHEN f.signup = 1 AND f.trial = 1 THEN 1 ELSE 0 END) AS trial_users,
    SUM(CASE WHEN f.signup = 1 AND f.trial = 1 AND f.activated = 1 THEN 1 ELSE 0 END) AS activated_users,
    COUNT(DISTINCT p.customer_id) AS paid_users,
    COUNT(DISTINCT c.customer_id) AS churned_users
FROM funnel_events f
LEFT JOIN paid_customers p
    ON f.customer_id = p.customer_id
LEFT JOIN churned_customers c
    ON f.customer_id = c.customer_id;
