## Repository Structure

data-analyst-assessment/
├── data/
├── sql/
├── python/
├── dashboard/
└── README.md
## Funnel Analysis

### Funnel Stages
Signup → Trial → Activated → Paid → Churned

### Event Mapping
- Signup: events_clean.event_type = 'signup'
- Trial: events_clean.event_type = 'trial_start'
- Activated: events_clean.event_type = 'activated'
- Paid: customer exists in subscriptions_clean
- Churned: subscriptions_clean.end_date IS NOT NULL

### Key Findings
- 67.6% of users move from signup to trial
- 59.8% of trial users reach activation
- 90.6% of users convert to paid
- Paid users exceed activated users, indicating possible direct-to-paid conversions or incomplete activation tracking
- Paid churn rate is ~24.6%

### Assumptions & Limitations
- Funnel events may not capture all user actions
- Payment does not strictly depend on activation events

## Dashboard (Power BI)

A Power BI dashboard was created to visualize SaaS growth and GTM performance using cleaned data from MySQL.

### Data Source
- Power BI visuals were built using CSV exports from cleaned MySQL views
- MySQL was used for all data cleaning, transformation, and metric calculations
- CSVs were used in Power BI to avoid database connector dependencies

### Visuals Included
- Monthly MRR trend to track revenue performance over time
- User conversion funnel from signup to churn
- Monthly customer churn overview
- Paid customer distribution by customer segment

### Funnel Visualization Notes
- Funnel values were derived from MySQL funnel analysis
- Due to Power BI funnel aggregation behavior, a stage-based measure was used
- Automatic display unit scaling was disabled to prevent rounding issues

### Churn Visualization Notes
- Churn was calculated using subscriptions with a non-null end_date
- Churn was aggregated at a monthly level using a MonthStart column
- Date hierarchy was disabled to avoid daily-level noise
