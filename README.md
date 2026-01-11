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
Key Insights

1. Strong top-of-funnel but drop during activation
While all users complete signup and ~68% reach the trial stage, only ~40% of users complete activation. This indicates a significant drop-off between trial and activation, likely caused by onboarding friction or unclear activation milestones.

2. High paid conversion despite lower activation
Approximately 90.6% of users convert to paid plans, which exceeds the number of activated users. This suggests either direct-to-paid conversions or incomplete activation event tracking.

3. Early-stage churn concentration
Monthly churn is highest in the initial months and decreases over time, indicating early retention challenges commonly seen in B2B SaaS products.

4. SMB and Enterprise drive most paid users
SMB and Enterprise segments contribute the majority of paid customers, while Mid-Market and Unknown segments show lower engagement.

Recommendations

1. Improve trial-to-activation experience

Simplify onboarding and highlight activation milestones clearly.

Add product guidance and in-app nudges during the trial period.

Review activation event tracking to ensure it reflects meaningful product usage.

2. Strengthen early retention strategies

Introduce customer success touchpoints in the first 30 days.

Identify and address early churn reasons through cohort analysis.

3. Improve customer segmentation quality

Reduce “Unknown” segment through better data capture.

Use segment-specific messaging and onboarding strategies.
Next Steps

Analyze conversion and churn by acquisition source.

Build cohort-based retention analysis.

Track activation-to-paid timelines to validate funnel accuracy.
