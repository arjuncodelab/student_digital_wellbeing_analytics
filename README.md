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
  - With Higher Brain Rot **29.80** out of 60:- Have Productivity of **7.94** Out of 10.

Students in the high brain rot group score up to Max of 59 and Min of 22.47 out of 60, indicating severe digital addiction patterns. Even among high-attendance students (>80%), this cognitive deterioration remains consistent, suggesting brain rot is independent of effort and attendance—it's about quality of focus, not quantity of time spent.

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





# Relational Data Analysis: Student Digital Behavior & Psychological Metrics

## 📌 Project Overview
This repository contains a deep-dive SQL data analysis exploring how digital lifestyle variables—specifically screen time, social media immersion, short-form video consumption, and ad engagement—impact student productivity, academic standing, and mental wellbeing. 

Using advanced SQL techniques including window functions (`PERCENT_RANK`), complex multi-table joins, and conditional case aggregations, this project queries a normalized relational database containing **360,183 student profiles** to map modern behavioral trends.

---

## 📊 Core Hypotheses & SQL Query Findings

The analysis was driven by 9 core behavioral and structural research questions:

### 1. The Internet Wellbeing Tipping Point
* **Goal:** Determine if an increasing volume of internet access correlates with a clear degradation of personal wellbeing.
* **Finding:** A distinct inverse relationship exists. Students in the highest tertile of internet use spend double the time on social media and experience a notable drop in their average wellbeing scores compared to low-use students.

```
+----------+--------------------------+---------------+----------------------+
| Quartile | avg_internet_access_hour | avg_wellbeing | avg_social_media_use |
+----------+--------------------------+---------------+----------------------+
| High     | 6.73                     | 52.24         | 4.32                 |
| Mid      | 4.99                     | 57.34         | 3.35                 |
| Low      | 3.26                     | 62.36         | 2.38                 |
+----------+--------------------------+---------------+----------------------+
```

### 2. The "Brain Rot" Productivity Tax
* **Goal:** Quantify the toll that elevated digital consumer indexes have on classroom presence, focus window, and individual efficiency.
* **Finding:** High "Brain Rot" indices heavily penalize student metrics. Students classified in the high-exposure group suffer an attention span drop and significantly lower overall productivity scores.

```
+--------------------+-----------------------+---------------+------------------+----------------------------+
|  brain_rot_group   | class_attendance_rate | avg_brain_rot | avg_productivity | avg_attention_span_minutes |
+--------------------+-----------------------+---------------+------------------+----------------------------+
| Low_brain_rot      | 93.13                 | 9.22          | 9.57             | 56.7                       |
| Moderate_brain_rot | 90.99                 | 18.47         | 8.99             | 54.1                       |
| High_brain_rot     | 88.28                 | 29.08         | 7.94             | 50.4                       |
+--------------------+-----------------------+---------------+------------------+----------------------------+
```

### 3. Behavioral Spending vs. Socioeconomic Backgrounds
* **Goal:** Is ad click-through frequency a more aggressive driver of online spending and impulse buying than family income bracket?
* **Finding:** While high-income students spend the most cash in absolute numbers, **ad engagement dictates the impulse score**. A low-income student with high ad engagement demonstrates an impulse score (`6.71`) virtually identical to a high-income counterpart (`6.79`), proving marketing vulnerability spans all economic tiers.

### 4. Macro Infrastructure & Country-Level Performance ROI
* **Goal:** Analyze student performance and regional productivity thresholds against global variations in internet infrastructure capabilities.
* **Finding:** Highly developed infrastructures (e.g., USA, UK, Canada) yield dense distributions of academically motivated students. Conversely, tracking peak workspace productivity metrics maps a heavily distributed student concentration across emerging and developing markets.

### 5. Short-Form Video Penetration ("Doom Scrolling") by Major
* **Goal:** Uncover which fields of study are disproportionately consumed by short-form video ratios relative to their baseline connectivity.
* **Finding:** Aggregate calculations show a uniform **0.30 (30%) ratio** across all core subject fields (STEM, Arts, Business, Law, Medicine, Social Sciences), indicating that algorithmic short-form consumption acts as a universal baseline distraction vector irrespective of a student's chosen discipline.

### 6. Multi-Factor Academic Risk Profiling
* **Goal:** Isolate the volumetric clusters of students suffering from a "Triple Threat" profile: elevated late-night use, structural anxiety spikes, and low attendance.
* **Finding:** The segment categorized as "High Risk" correlates sharply with an elevated average anxiety score (`6.62`) and heavily degraded class attendance metrics (`86.25%`).

```
+----------------+---------------+-------------+----------------------+---------------------------+
| Risk_assesment | avg_brain_rot | avg_anxiety | avg_late_night_score | avg_class_attendance_rate |
+----------------+---------------+-------------+----------------------+---------------------------+
| High_Risk      | 29.27         | 6.62        | 2.26                 | 86.25                     |
| Lower Risk     | 12.73         | 3.34        | 0.71                 | 97.48                     |
| Standard_Risk  | 18.21         | 4.86        | 0.95                 | 89.89                     |
+----------------+---------------+-------------+----------------------+---------------------------+
```

### 7. Economic Resilience & Geographic Development Tiers
* **Goal:** Evaluate how macroeconomic development tiers affect fundamental student wellbeing metrics across matching internal income brackets.
* **Finding:** Counterintuitively, average student wellbeing indexes scale higher as national macro-infrastructure complexity drops, with Underdeveloped nations maintaining higher baseline wellbeing metrics (`~60.7`) relative to Developed nations (`~53.8`), unaffected by localized household financial status.

### 8. Hardware Access Disparity Matrix
* **Goal:** Determine if device restrictions (Shared Devices, Smartphones, Laptops) amplify behavioral vulnerabilities and downregulate academic performance.
* **Finding:** Device profiles show consistent variance across isolated risk segments. Users bound strictly to laptops or combinations of devices ("Both") reveal marginal increases in their average brain rot metrics when slipping into high-risk behavior pools, while shared device users maintain slightly lower baseline scores.

### 9. The Digital Addiction Recovery Benchmark ("Gold Standard")
* **Goal:** Calculate the precise outlier proportion of the student demographic capable of successfully balancing high study routines alongside minimized social media usage.
* **Finding:** **Only 7% of the entire student database** satisfies the optimal recovery criteria. This elite subset preserves an average attention span of **58.79 minutes**, outperforming the broader population trimmed mean baseline.

---

## Database Optimization & Performance Profile
To facilitate high-speed querying across the multi-table joins required for this analysis, B-Tree database indexes were integrated directly across primary relational constraints.

* **Query Footprint:** 360,183 Records**.
* **Pre-Index Execution Time:** **708.24 seconds**.
* **Post-Index Execution Time:** **0.0011 seconds**.
* **Performance Gain:** **99.9% query latency reduction**, transforming expensive sequential table scans into immediate index lookups.

---
