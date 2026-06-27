-- Q1 Wellbeing Tipping point
-- Goal: Identify if there is a 'cliff' where internet usage destroys wellbeing.
WITH q AS (
    SELECT
    student_id,
    internet_access_hours,
    wellbeing_index,
    social_media_hours,
    PERCENT_RANK() OVER(ORDER BY internet_access_hours) AS 'percentile_rank'
    FROM students
    ORDER BY student_id
)
SELECT
 CASE
  WHEN percentile_rank <= 0.33 THEN 'Low'
  WHEN percentile_rank <= 0.66 THEN 'Mid'
  ELSE 'High'
  END as 'Tertile',
  ROUND(AVG(internet_access_hours),2) as avg_internet_access_hour,
  ROUND(AVG(wellbeing_index),2) AS avg_wellbeing,
  ROUND(AVG(social_media_hours),2) AS avg_social_media_use
  FROM q
  GROUP BY Tertile
  ORDER BY avg_internet_access_hour DESC, avg_wellbeing DESC
;

-- Q2 Brain Rot Productive Tax
-- Goal: Do students with above average 'Brain Rot' scores (out of 60) actually perform worse?
WITH students_filtered AS (
  SELECT student_id,
  PERCENT_RANK() OVER(ORDER BY brain_rot_index) as quantile
  FROM students
  ORDER BY student_id
)
SELECT
  CASE
    WHEN s.quantile >= 0.66 THEN 'High_brain_rot'
    WHEN s.quantile < 0.66 AND s.quantile >= 0.33 THEN 'Moderate_brain_rot'
    ELSE "Low_brain_rot"
  END AS brain_rot_group,
  ROUND(AVG(st.class_attendance_rate),2) as class_attendance_rate,
  ROUND(AVG(st.brain_rot_index), 2) as avg_brain_rot,
  ROUND(AVG(st.productivity_score),2) AS avg_productivity,
  MAX(st.brain_rot_index) as max_brain_rot,
  MIN(st.brain_rot_index) as min_brain_rot,
  ROUND(AVG(st.attention_span_minutes), 2) AS avg_attention_span_minutes
FROM students_filtered s
JOIN students st ON s.student_id = st.student_id
GROUP BY brain_rot_group
ORDER BY avg_productivity DESC, avg_brain_rot DESC;


-- Q3 Behavioral Spending
-- Goal: Is ads_clickeding a stronger driver of spending than family income?
WITH average_cte AS (
    SELECT
    student_id,
    PERCENT_RANK() OVER (ORDER BY ads_clicked_per_week) as percentile
    FROM students
    ORDER BY student_id
)
SELECT
 f.family_income,
 CASE
  WHEN ac.percentile >= 0.6666 THEN 'High'
  WHEN ac.percentile >= 0.3333 AND ac.percentile < 0.6666 THEN 'Moderate'
 ELSE 'Low'
 END AS ad_engagement,
 ROUND(AVG(s.ads_clicked_per_week),2) AS avg_ads_click_per_week,
 ROUND(AVG(s.digital_spending_per_month),2) AS avg_digital_spending_per_month,
 ROUND(AVG(s.impulse_purchase_score), 2) AS avg_impulse_score
FROM students s
JOIN average_cte ac ON s.student_id = ac.student_id
JOIN family_income f ON s.family_income_id = f.family_income_id
GROUP BY f.family_income, ad_engagement
ORDER BY avg_ads_click_per_week DESC, avg_digital_spending_per_month DESC;


-- Q4 Infrastructure ROI
-- Goal: Does better internet speed actually result in higher academic motivation? -Yes
WITH percentile_academic_motivation AS (
    SELECT
      student_id,
      country_id,
      PERCENT_RANK() OVER (ORDER BY academic_motivation) as percentile_academic_motivation
    FROM students
    ORDER BY student_id
),
percentile_internet_infra AS(
    SELECT
        country_id,
        country,
        PERCENT_RANK() OVER(ORDER BY internet_infrastructure_index) AS percentile_internet_infra,
        internet_infrastructure_index
    FROM countries
    ORDER BY country_id
)
SELECT
    pc.country,
    pc.internet_infrastructure_index,
    ROUND(AVG(CASE WHEN pa.percentile_academic_motivation >= 0.66
         THEN 1 ELSE 0 END) * 100 ,2) AS High_perform_students_pct,
    ROUND(AVG(CASE WHEN pa.percentile_academic_motivation >= 0.33 AND pa.percentile_academic_motivation < 0.66
         THEN 1 ELSE 0 END) * 100 ,2) AS Moderate_perform_students_pct,
    ROUND(AVG(CASE WHEN pa.percentile_academic_motivation < 0.33
         THEN 1 ELSE 0 END) * 100, 2) AS Low_perform_students_pct
FROM percentile_academic_motivation pa
JOIN percentile_internet_infra pc ON pa.country_id = pc.country_id
GROUP BY pc.country, pc.internet_infrastructure_index
ORDER BY High_perform_students_pct DESC, Moderate_perform_students_pct DESC, Low_perform_students_pct DESC;


-- Yes better infrastructure lead to Not just better academic performance but better productivity too

WITH percentile_productivity_score AS (
    SELECT
      student_id,
      country_id,
      PERCENT_RANK() OVER (ORDER BY productivity_score) as percentile_productivity_score
    FROM students
    ORDER BY student_id
),
percentile_internet_infra AS(
    SELECT
        country_id,
        country,
        PERCENT_RANK() OVER(ORDER BY internet_infrastructure_index) AS percentile_internet_infra,
        internet_infrastructure_index
    FROM countries
    ORDER BY country_id
)
SELECT
    pc.country,
    pc.internet_infrastructure_index,
    ROUND(AVG(CASE WHEN pa.percentile_productivity_score >= 0.66
         THEN 1 ELSE 0 END) * 100, 2) AS High_productivity_score_pct,
    ROUND(AVG(CASE WHEN pa.percentile_productivity_score >= 0.33 AND pa.percentile_productivity_score < 0.66
         THEN 1 ELSE 0 END) * 100, 2) AS Moderate_productivity_score_pct,
    ROUND(AVG(CASE WHEN pa.percentile_productivity_score < 0.33
         THEN 1 ELSE 0 END) *100, 2) AS Low_productivity_score_pct
FROM percentile_productivity_score pa
JOIN percentile_internet_infra pc ON pa.country_id = pc.country_id
GROUP BY pc.country, pc.internet_infrastructure_index
ORDER BY High_productivity_score_pct DESC, Moderate_productivity_score_pct DESC, Low_productivity_score_pct DESC;



-- Q5 Doom Scrolling By Major
-- Goal: Which fields of study are most "addicted" to short-form content?
SELECT
 sf.field_of_study,
 ROUND(SUM(s.short_video_hours) / NULLIF(SUM(s.internet_access_hours),0), 2) as 'doom_scorll'
 FROM students s
 JOIN study_field sf ON s.study_field_id = sf.study_field_id
 GROUP BY sf.field_of_study
 ORDER BY doom_scorll DESC;


-- Q6 Multi_factor Academic_risk.
-- Goal: Identify the volume of studnets meeting the 'Triple Threat"
-- Criteria: High Late Night usage, Low attendance and High Anxiety.
WITH CTE AS (
    SELECT
        student_id,
        PERCENT_RANK() OVER(ORDER BY class_attendance_rate) AS 'percentile_attendance',
        PERCENT_RANK() OVER(ORDER BY anxiety_score) AS 'percentile_anxiety_score'
    FROM students
    ORDER BY student_id
)
SELECT
    CASE
        WHEN s.late_night_score >= 2 AND c.percentile_attendance <= 0.66 AND c.percentile_anxiety_score >= 0.5
            THEN 'High_Risk'
        WHEN c.percentile_attendance > 0.66 AND c.percentile_anxiety_score < 0.5 THEN 'Lower Risk'
        ELSE 'Standard_Risk'
    END as 'Risk_assesment',
        ROUND(AVG(s.brain_rot_index),2) as avg_brain_rot,
        ROUND(AVG(s.anxiety_score),2) AS avg_anxiety,
        ROUND(AVG(s.late_night_score),2) AS avg_late_night_score,
        ROUND(AVG(s.class_attendance_rate),2) AS avg_class_attendance_rate
        FROM students s
        JOIN CTE c ON s.student_id = c.student_id
        GROUP BY Risk_assesment;

-- -- Q7 Economic_resilience
-- -- Goal: Compare how family income affects wellbeing across different country development levels.

SELECT
 d.development_level,
 CASE
    WHEN f.family_income = 'High' THEN 'High_income'
    WHEN f.family_income = 'Low' THEN 'Low_income'
    WHEN f.family_income = 'Middle' THEN 'Middle_income'
 END AS family_income,
 ROUND(AVG(s.wellbeing_index),2) AS avg_wellbeing_score,
 COUNT(s.student_id) AS size
FROM students s
JOIN countries c ON s.country_id = c.country_id
JOIN development d ON c.development_id = d.development_id
JOIN family_income f ON s.family_income_id = f.family_income_id
GROUP BY d.development_level,family_income
ORDER BY d.development_level;


-- Q8 Device Access Parity
-- Goal: Measure the Academic Risk differene between students
WITH cte AS (
    SELECT
    s.student_id,
    PERCENT_RANK() OVER(ORDER BY s.academic_risk_score) AS percentile_academic_risk,
    PERCENT_RANK() OVER(ORDER BY s.productivity_score) AS percentile_productivity_score
    FROM students s
    ORDER BY student_id
)
SELECT d.device_access,
 CASE
    WHEN c.percentile_academic_risk > 0.66 THEN 'high'
    WHEN c.percentile_academic_risk <= 0.66 AND c.percentile_academic_risk > 0.33
        THEN 'Moderate'
    ELSE 'Low'
    END AS academic_risk_assessment,
 ROUND(AVG(s.brain_rot_index), 2) as avg_brain_rot,
 ROUND(AVG(s.productivity_score), 2) as avg_productiviy
FROM students s
JOIN device_access d ON s.device_id = d.device_id
JOIN cte c ON s.student_id = c.student_id
GROUP BY d.device_access, academic_risk_assessment
ORDER BY avg_productiviy DESC;


-- Q9 Digital Addiction Recovery, The Gold Standard Student
-- Goal: What percentage of students successfully balance high study and low social media?
-- only 7% meet the criteria

WITH cte AS (
    SELECT
        student_id,
        PERCENT_RANK() OVER(ORDER BY social_media_hours) AS social_media_usage,
        PERCENT_RANK() OVER(ORDER BY study_hours_per_week) AS percent_study_hour,
        PERCENT_RANK() OVER(ORDER BY attention_span_minutes) AS percentile_attention_span,
        attention_span_minutes,
        study_hours_per_week,
        social_media_hours
    FROM students
    ORDER BY student_id
)
SELECT
 (SUM(CASE WHEN social_media_usage < 0.25 AND percent_study_hour > 0.75 THEN 1 ELSE 0 END) * 100)/
 COUNT(student_id) AS Gold_Standard_Attention_PCT_in_Students,
 ROUND(AVG((SELECT attention_span_minutes FROM cte WHERE percentile_attention_span BETWEEN 0.2 AND 0.8 )),2)
    AS trimmed_mean_attention_span,
 ROUND(AVG(CASE WHEN social_media_usage < 0.25 AND percent_study_hour > 0.75 THEN attention_span_minutes END),2)
 AS golden_standard_avg_attention_span
FROM cte
;
