USE medicore_hospital;

-- Monthly Hospital Admission Trends

SELECT
    DATE_FORMAT(admission_date, '%Y-%m') AS admission_month,
    COUNT(admission_id) AS total_admissions,
    COUNT(DISTINCT patient_id) AS unique_patients,
    SUM(CASE
        WHEN admission_type = 'Emergency' THEN 1
        ELSE 0
    END) AS emergency_admissions,
    SUM(CASE
        WHEN admission_type = 'Scheduled' THEN 1
        ELSE 0
    END) AS scheduled_admissions,
    ROUND(AVG(length_of_stay_days), 2) AS avg_length_of_stay
FROM admissions
GROUP BY DATE_FORMAT(admission_date, '%Y-%m')
ORDER BY admission_month;
