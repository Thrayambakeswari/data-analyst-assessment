-- 03_core_metrics.sql
-- Core SaaS metrics: MRR, ARR, customer churn, revenue churn

-- Generate monthly timeline
CREATE OR REPLACE VIEW months AS
SELECT DISTINCT
    DATE_FORMAT(start_date, '%Y-%m-01') AS month_start
FROM subscriptions_clean
WHERE start_date IS NOT NULL;

-- Monthly MRR
CREATE OR REPLACE VIEW monthly_mrr AS
SELECT
    m.month_start,
    SUM(s.monthly_price) AS mrr
FROM months m
JOIN subscriptions_clean s
  ON s.start_date <= m.month_start
 AND (s.end_date IS NULL OR s.end_date >= m.month_start)
GROUP BY m.month_start;

-- ARR
CREATE OR REPLACE VIEW monthly_arr AS
SELECT
    month_start,
    mrr,
    mrr * 12 AS arr
FROM monthly_mrr;

-- Customer churn
CREATE OR REPLACE VIEW customer_churn AS
SELECT
    DATE_FORMAT(end_date, '%Y-%m-01') AS churn_month,
    COUNT(DISTINCT customer_id) AS churned_customers
FROM subscriptions_clean
WHERE end_date IS NOT NULL
GROUP BY churn_month;

-- Active customers at start of month
CREATE OR REPLACE VIEW active_customers_start_month AS
SELECT
    m.month_start,
    COUNT(DISTINCT s.customer_id) AS active_customers
FROM months m
JOIN subscriptions_clean s
  ON s.start_date < m.month_start
 AND (s.end_date IS NULL OR s.end_date >= m.month_start)
GROUP BY m.month_start;

-- Customer churn rate
CREATE OR REPLACE VIEW customer_churn_rate AS
SELECT
    a.month_start,
    COALESCE(c.churned_customers, 0) AS churned_customers,
    a.active_customers,
    ROUND(
        COALESCE(c.churned_customers, 0) / a.active_customers * 100,
        2
    ) AS churn_rate_percent
FROM active_customers_start_month a
LEFT JOIN customer_churn c
  ON a.month_start = c.churn_month;

-- Revenue churn
CREATE OR REPLACE VIEW revenue_churn AS
SELECT
    DATE_FORMAT(end_date, '%Y-%m-01') AS churn_month,
    SUM(monthly_price) AS churned_mrr
FROM subscriptions_clean
WHERE end_date IS NOT NULL
GROUP BY churn_month;

-- Revenue churn rate
CREATE OR REPLACE VIEW revenue_churn_rate AS
SELECT
    m.month_start,
    COALESCE(r.churned_mrr, 0) AS churned_mrr,
    mrr.mrr AS starting_mrr,
    ROUND(
        COALESCE(r.churned_mrr, 0) / mrr.mrr * 100,
        2
    ) AS revenue_churn_percent
FROM months m
JOIN monthly_mrr mrr
  ON m.month_start = mrr.month_start
LEFT JOIN revenue_churn r
  ON m.month_start = r.churn_month;
