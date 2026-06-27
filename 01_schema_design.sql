DROP TABLE IF EXISTS students;
CREATE TABLE students (
  "student_id" INTEGER,
  "country_id" INTEGER,
  "development_id" INTEGER,
  "age" INTEGER,
  "gender" TEXT NOT NULL CHECK(gender IN ('Male','Female','Other')),
  "urban_rural" TEXT NOT NULL CHECK(urban_rural IN ('Urban', 'Rural')),
  "family_income_id" INTEGER,
  "device_id" INTEGER,
  "internet_access_hours" DECIMAL,
  "education_id" INTEGER,
  "study_field_id" INTEGER,
  "academic_motivation" DECIMAL,
  "online_learning_hours" DECIMAL,
  "social_media_hours" DECIMAL,
  "sessions_per_day" DECIMAL,
  "average_session_length_minutes" DECIMAL,
  "late_night_usage" INTEGER,
  "education_content_hours" DECIMAL,
  "short_video_hours" DECIMAL,
  "entertainment_content_hours" DECIMAL,
  "news_content_hours" DECIMAL,
  "likes_given_per_day" DECIMAL,
  "comments_written_per_day" DECIMAL,
  "posts_created_per_week" DECIMAL,
  "late_night_score" INTEGER,
  "brain_rot_index" DECIMAL,
  "brain_rot_level" INTEGER,
  "attention_span_minutes" DECIMAL,
  "study_hours_per_week" DECIMAL,
  "class_attendance_rate" DECIMAL,
  "productivity_score" DECIMAL,
  "sleep_hours" DECIMAL,
  "stress_level" DECIMAL,
  "anxiety_score" DECIMAL,
  "depression_score" DECIMAL,
  "ads_clicked_per_week" DECIMAL,
  "ads_viewed_per_day" DECIMAL,
  "impulse_purchase_score" DECIMAL,
  "digital_spending_per_month" DECIMAL,
  "cyberbullying_exposure" INTEGER,
  "adult_content_exposure" INTEGER,
  "digital_addiction_score" DECIMAL,
  "wellbeing_index" DECIMAL,
  "academic_risk_score" INTEGER,
  "financial_risk_score" DECIMAL,
  PRIMARY KEY (student_id),
  FOREIGN KEY (country_id) REFERENCES countries(country_id),
  FOREIGN KEY (development_id) REFERENCES development(development_id),
  FOREIGN KEY (family_income_id) REFERENCES family_income(family_income_id),
  FOREIGN KEY (education_id) REFERENCES education_level(education_id),
  FOREIGN KEY (study_field_id) REFERENCES study_field(study_field_id),
  FOREIGN KEY (device_id) REFERENCES device_access(device_id)
);


DROP TABLE IF EXISTS education_level;
CREATE TABLE education_level(
    "education_id" INTEGER,
    "education_level" TEXT NOT NULL UNIQUE,
    PRIMARY KEY (education_id)
);


DROP TABLE IF EXISTS study_field;
CREATE TABLE study_field (
    "study_field_id" INTEGER,
    "field_of_study" TEXT UNIQUE NOT NULL,
    PRIMARY KEY (study_field_id)
);


DROP TABLE IF EXISTS device_access;
CREATE TABLE device_access(
    "device_id" INTEGER,
    "device_access" TEXT NOT NULL UNIQUE,
    PRIMARY KEY (device_id)
);


DROP TABLE IF EXISTS family_income;
CREATE TABLE family_income (
  "family_income_id" INTEGER,
  "family_income" TEXT UNIQUE,
  PRIMARY KEY (family_income_id)
);

DROP TABLE IF EXISTS countries;
CREATE TABLE countries (
  "country_id" INTEGER,
  "country" TEXT,
  "development_id" INTEGER,
  "poverty_rate_percent" DECIMAL,
  "internet_infrastructure_index" DECIMAL,
  "average_internet_speed_mbps" DECIMAL,
  PRIMARY KEY (country_id)
  FOREIGN KEY (development_id) REFERENCES development(development_id)
);

DROP TABLE IF EXISTS development;
CREATE TABLE development (
  "development_id" INTEGER,
  "development_level" TEXT UNIQUE NOT NULL CHECK (development_level IN ('Developed','Developing','Underdeveloped')),
  PRIMARY KEY (development_id)
);

DROP TABLE IF EXISTS mixed;
CREATE TABLE mixed (
  "student_id" INTEGER,
  "country" TEXT,
  "development_level" TEXT,
  "poverty_rate_percent" DECIMAL,
  "internet_infrastructure_index" DECIMAL,
  "average_internet_speed_mbps" DECIMAL,
  "age" INTEGER,
  "gender" TEXT,
  "urban_rural" TEXT,
  "family_income_level" TEXT,
  "device_access" TEXT,
  "internet_access_hours" DECIMAL,
  "education_level" TEXT,
  "field_of_study" TEXT,
  "academic_motivation" DECIMAL,
  "online_learning_hours" DECIMAL,
  "social_media_hours" DECIMAL,
  "sessions_per_day" DECIMAL,
  "average_session_length_minutes" DECIMAL,
  "late_night_usage" INTEGER,
  "education_content_hours" DECIMAL,
  "short_video_hours" DECIMAL,
  "entertainment_content_hours" DECIMAL,
  "news_content_hours" DECIMAL,
  "likes_given_per_day" DECIMAL,
  "comments_written_per_day" DECIMAL,
  "posts_created_per_week" DECIMAL,
  "late_night_score" INTEGER,
  "brain_rot_index" DECIMAL,
  "brain_rot_level" INTEGER,
  "attention_span_minutes" DECIMAL,
  "study_hours_per_week" DECIMAL,
  "class_attendance_rate" DECIMAL,
  "productivity_score" DECIMAL,
  "sleep_hours" DECIMAL,
  "stress_level" DECIMAL,
  "anxiety_score" DECIMAL,
  "depression_score" DECIMAL,
  "ads_clicked_per_week" DECIMAL,
  "ads_viewed_per_day" DECIMAL,
  "impulse_purchase_score" DECIMAL,
  "digital_spending_per_month" DECIMAL,
  "cyberbullying_exposure" INTEGER,
  "adult_content_exposure" INTEGER,
  "digital_addiction_score" DECIMAL,
  "wellbeing_index" DECIMAL,
  "academic_risk_score" INTEGER,
  "financial_risk_score" DECIMAL
);


CREATE VIEW student_data AS
  SELECT
    st.student_id,
    c.country,
    d.development_level,
    c.poverty_rate_percent,
    c.internet_infrastructure_index,
    c.average_internet_speed_mbps,
    st.age,
    st.gender,
    st.urban_rural,
    f.family_income,
    da.device_access,
    st.internet_access_hours,
    e.education_level,
    s.field_of_study,
    st.academic_motivation,
    st.online_learning_hours,
    st.social_media_hours,
    st.sessions_per_day,
    st.average_session_length_minutes,
    st.late_night_usage,
    st.education_content_hours,
    st.short_video_hours,
    st.entertainment_content_hours,
    st.news_content_hours,
    st.likes_given_per_day,
    st.comments_written_per_day,
    st.posts_created_per_week,
    st.late_night_score,
    st.brain_rot_index,
    st.brain_rot_level,
    st.attention_span_minutes,
    st.study_hours_per_week,
    st.class_attendance_rate,
    st.productivity_score,
    st.sleep_hours,
    st.stress_level,
    st.anxiety_score,
    st.depression_score,
    st.ads_clicked_per_week,
    st.ads_viewed_per_day,
    st.impulse_purchase_score,
    st.digital_spending_per_month,
    st.cyberbullying_exposure,
    st.adult_content_exposure,
    st.digital_addiction_score,
    st.wellbeing_index,
    st.academic_risk_score,
    st.financial_risk_score
FROM students st
JOIN countries c ON st.country_id = c.country_id
JOIN development d ON c.development_id = d.development_id
JOIN education_level e ON st.education_id = e.education_id
JOIN family_income f ON st.family_income_id = f.family_income_id
JOIN study_field s ON st.study_field_id = s.study_field_id
JOIN device_access da ON st.device_id = da.device_id
ORDER BY st.student_id
;



-- without index it took 708.245310 sec user 13.047501 sys 4.786965 for 360183 row of data with join
-- before index explain = real 0.002147 user 0.001050 sys 0.000000

CREATE INDEX idx_students_country_id ON students(country_id);
CREATE INDEX idx_students_education_id ON students(education_id);
CREATE INDEX idx_students_family_income_id ON students(family_income_id);
CREATE INDEX idx_students_study_field_id ON students(study_field_id);
CREATE INDEX idx_students_device_id ON students(device_id);
CREATE INDEX idx_countries_development_id ON countries(development_id);

-- after index =  real 0.001111 user 0.000169 sys 0.000944

