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
