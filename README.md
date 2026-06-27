## Student Wellbeing & Digital Behavior Analysis
#### Project Goal
In an era of increasing digital consumption, how does "Doom-Scrolling" affect the academic success of students globally? I designed a relational database to audit 360K+ student records, identifying the tipping point where digital addiction leads to academic failure.

#### The Architecture: : [Dataset](https://www.kaggle.com/datasets/ea5e73b3f8466a5cedaf3eaf45e5453cf91ab78cf77f12a7ed68ae829c14f402)
- **Normalization**: 01_schema_design.sql
Transformed a flat 'Mixed' dataset into a relational schema (Students, Countries, family_income, Device_access, Education_level, Field_of_study.).

- **Data Integrity**: 02_data_etl.sql
Implemented strict CHECK constraints and Foreign Key relationships to ensure zero data leakage.

- **The Insights**: 03_queries_used_for_analytical_insights.sql

#### Key Findings
- **Wellbeing Tipping Point** | _Goal_: Identify if there is a 'cliff' where internet usage destroys wellbeing.
- **Insight**: Students with 3 hours of daily internet access report the highest wellbeing scores (63.1), representing optimal digital health. However, as usage increases, wellbeing deteriorates steadily:

  Safe Zone 3 hours/day -> Wellbeing: 63.1

  Warning Zone 4.7 hours/day -> Wellbeing: 57.34

  Danger Zone 6.73 hours/day -> Wellbeing: 52.38 | Critical threshold

Beyond 6.7 hours (7 h aprox), students experience a 10-point wellbeing decline from the optimal range. This suggests a "danger zone" where excessive screen time becomes psychologically destructive.


- **Brain Rot Productivity Tax** | _Goal_: Do students with Higher 'Brain Rot' scores have lower Productivity?

**Insight**: Students with above-average brain rot scores show a 12% productivity decline: (Lower = Better)
  - With Lower Brain Rot **9.22** out of 60 :- Have Productivity of **9.57** Out of 10.
  - With Moderate Brain Rot **18.14** out of 60 :- Have Productivity **8.29** Out of 10.
  - With Higher Brain Rot **29.80** out of 60:- Have Productivity of **7.94

Students in the high brain rot group score up to Max of 59 out of 60, indicating severe digital addiction patterns. Even among high-attendance students (>80%), this cognitive deterioration remains consistent, suggesting brain rot is independent of effort and attendance—it's about quality of focus, not quantity of time spent.

- **Behavioral Spending & Ad Engagement** | _Goal_: Is ad clicking a stronger driver of spending than family income?

**Insight**: A student from a low-income family with high ad engagement ($35.62/month) spends more than a high-income student with low ad engagement ($53.94 is still lower than $100). More importantly, impulse scores remain consistently high (5.3-5.6) across all income levels when ad engagement is high, proving that algorithmic manipulation bypasses socioeconomic safeguards.


-**Multi-Factor Academic Risk** | _Goal_: Identify the volume of students meeting the "Triple Threat" criteria: High Late Night usage + Low attendance + High Anxiety.
- **Insight**: Only 53 students out of 500,000 (0.01%) meet all three criteria simultaneously, but they are in severe academic and mental health crisis. These high-risk students show an anxiety score of 7.95 compared to 4.86 for standard-risk students—a 63% increase. More alarming, their class attendance rate collapses to 68.23% versus 90.77% for standard-risk peers, a 22-percentage-point difference.

These students are trapped in a vicious psychological cycle: late-night internet scrolling disrupts sleep patterns -> sleep deprivation reduces motivation for daytime classes -> missed classes increase academic anxiety -> heightened anxiety drives more late-night escapism through scrolling -> the cycle deepens. Though statistically rare, these 53 students represent early intervention failures and should be flagged by academic advisors and counseling services for immediate support. Early intervention could break the cycle before it becomes irreversible.


- **Economic_resilience** | _Goal_: Compare how family income affects wellbeing across different country development levels.
- **Insight**:  Students in underdeveloped regions report 7-point higher wellbeing than developed nations despite lower overall infrastructure. Possible explanations:
  - Lower social media penetration = less doom-scrolling
  - Stronger community/offline activities = better mental health
  - Lower economic pressure = reduced financial anxiety
  - Reduced ad exposure = fewer impulse spending triggers
- _**Implication**_: Digital wellbeing may be inversely correlated with development level, challenging the narrative that "more technology = better outcomes."

- **Device Access Parity** | _Goal_: Measure the Academic Risk differene between students.
- **Insight**: Giving students more devices increases their risk profiles and lowers productivity. Students with shared device access show the lowest risk score (0.09) and highest productivity (8.90). Students with only smartphones increase risk to 0.11 with productivity at 8.84. Laptop-only users show 0.12 risk and 8.77 productivity. Students with both smartphones and laptops—seemingly the best-equipped—show the highest risk (0.13) and lowest productivity (8.74).

This suggests that shared devices create natural friction that protects users: waiting for family members to finish, and limited availability unintentionally prevent compulsive doom-scrolling. Conversely, unlimited personal device access removes all friction, enabling addictive behavior. Students with both phone and laptop face no barriers to constant connectivity and are 44% riskier than shared-device users despite having superior tools.

-**_Implication_**: Policy should consider "friction as a feature"—controlled device access may be more protective than unlimited access.


- **Digital Addiction Recovery**:- The Gold Standard Student | _Goal_: What percentage of students successfully balance high study and low social media?
- **Insight**: The 14% who achieve the "gold standard".
   - Standard student: 53.7 min/study
   - Gold standard: 56.59 min/study
   - Advantage: 2.89 additional Minutes If continued for 50 session, it become 2.4 hours extra hours. Seemingly small, but influential over an academic year.
- **_Implication_**: Small behavioral changes (reducing social media) yield measurable cognitive improvements. The 14% "recovery rate" suggests digital addiction is reversible with intentional effort.


