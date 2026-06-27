# Relational Data Analysis: Student Digital Wellbeing Behavior

## Project Overview
This repository contains a deep-dive SQL data analysis exploring how digital lifestyle variables—specifically screen time, social media immersion, short-form video consumption, and ad engagement—impact student productivity, academic standing, and mental wellbeing. 

Using advanced SQL techniques including window functions (`PERCENT_RANK`), complex multi-table joins, and conditional case aggregations, this project queries a normalized relational database containing **360,183 student profiles** to map modern behavioral trends.

---

## Core Hypotheses & SQL Query Findings

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
```
+---------------+---------------+------------------------+--------------------------------+-------------------+
| family_income | ad_engagement | avg_ads_click_per_week | avg_digital_spending_per_month | avg_impulse_score |
+---------------+---------------+------------------------+--------------------------------+-------------------+
| High          | High          | 135.47                 | 118.48                         | 6.79              |
| Middle        | High          | 134.49                 | 74.92                          | 6.76              |
| Low           | High          | 132.41                 | 42.23                          | 6.71              |
| High          | Moderate      | 95.74                  | 96.38                          | 5.4               |
| Middle        | Moderate      | 95.58                  | 61.85                          | 5.4               |
| Low           | Moderate      | 95.11                  | 35.73                          | 5.36              |
| High          | Low           | 62.57                  | 79.38                          | 4.34              |
| Middle        | Low           | 61.91                  | 51.54                          | 4.32              |
| Low           | Low           | 60.56                  | 30.58                          | 4.27              |
+---------------+---------------+------------------------+--------------------------------+-------------------+
```

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
```
+---------------+--------------------------+---------------+-----------------+
| device_access | academic_risk_assessment | avg_brain_rot | avg_productiviy |
+---------------+--------------------------+---------------+-----------------+
| Shared Device | Low                      | 17.53         | 8.96            |
| Smartphone    | Low                      | 18.3          | 8.9             |
| Laptop        | Low                      | 19.3          | 8.84            |
| Both          | Low                      | 19.88         | 8.82            |
| Shared Device | high                     | 32.06         | 7.08            |
| Smartphone    | high                     | 32.83         | 6.93            |
| Laptop        | high                     | 33.67         | 6.9             |
| Both          | high                     | 33.92         | 6.85            |
+---------------+--------------------------+---------------+-----------------+
```

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
