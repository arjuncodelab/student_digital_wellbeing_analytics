INSERT INTO device_access (device_access)
SELECT device_access FROM mixed GROUP BY device_access ORDER BY device_access;

INSERT INTO family_income (family_income)
SELECT family_income_level FROM mixed GROUP BY family_income_level ORDER BY family_income_level;

INSERT INTO study_field (field_of_study)
SELECT field_of_study FROM mixed GROUP BY field_of_study ORDER BY field_of_study;

INSERT INTO education_level (education_level)
SELECT education_level FROM mixed GROUP BY education_level ORDER BY education_level;

INSERT INTO development(development_level)
SELECT development_level FROM mixed GROUP BY development_level ORDER BY development_level;


INSERT INTO countries (country, development_id,
 poverty_rate_percent,
 internet_infrastructure_index,
 average_internet_speed_mbps)
SELECT
 m.country,
 d.development_id,
 m.poverty_rate_percent,
 m.internet_infrastructure_index,
 m.average_internet_speed_mbps
 FROM mixed m
 JOIN development d ON m.development_level = d.development_level
 GROUP BY country order by country;


INSERT INTO students (
    student_id,
    country_id,
    development_id,
    age,
    gender,
    urban_rural,
    family_income_id,
    device_id,
    internet_access_hours,
    education_id,
    study_field_id,
    academic_motivation,
    online_learning_hours,
    social_media_hours,
    sessions_per_day,
    average_session_length_minutes,
    late_night_usage,
    education_content_hours,
    short_video_hours,
    entertainment_content_hours,
    news_content_hours,
    likes_given_per_day,
    comments_written_per_day,
    posts_created_per_week,
    late_night_score,
    brain_rot_index,
    brain_rot_level,
    attention_span_minutes,
    study_hours_per_week,
    class_attendance_rate,
    productivity_score,
    sleep_hours,
    stress_level,
    anxiety_score,
    depression_score,
    ads_clicked_per_week,
    ads_viewed_per_day,
    impulse_purchase_score,
    digital_spending_per_month,
    cyberbullying_exposure,
    adult_content_exposure,
    digital_addiction_score,
    wellbeing_index,
    academic_risk_score,
    financial_risk_score
)
SELECT
    m.student_id,
    c.country_id,
    d.development_id,
    m.age,
    m.gender,
    m.urban_rural,
    f.family_income_id,
    da.device_id,
    m.internet_access_hours,
    e.education_id,
    s.study_field_id,
    m.academic_motivation,
    m.online_learning_hours,
    m.social_media_hours,
    m.sessions_per_day,
    m.average_session_length_minutes,
    m.late_night_usage,
    m.education_content_hours,
    m.short_video_hours,
    m.entertainment_content_hours,
    m.news_content_hours,
    m.likes_given_per_day,
    m.comments_written_per_day,
    m.posts_created_per_week,
    m.late_night_score,
    m.brain_rot_index,
    m.brain_rot_level,
    m.attention_span_minutes,
    m.study_hours_per_week,
    m.class_attendance_rate,
    m.productivity_score,
    m.sleep_hours,
    m.stress_level,
    m.anxiety_score,
    m.depression_score,
    m.ads_clicked_per_week,
    m.ads_viewed_per_day,
    m.impulse_purchase_score,
    m.digital_spending_per_month,
    m.cyberbullying_exposure,
    m.adult_content_exposure,
    m.digital_addiction_score,
    m.wellbeing_index,
    m.academic_risk_score,
    m.financial_risk_score
FROM mixed m
JOIN countries c ON m.country = c.country
JOIN development d ON m.development_level = d.development_level
JOIN education_level e ON m.education_level = e.education_level
JOIN family_income f ON m.family_income_level = f.family_income
JOIN study_field s ON m.field_of_study = s.field_of_study
JOIN device_access da ON m.device_access = da.device_access
ORDER BY m.student_id
;

