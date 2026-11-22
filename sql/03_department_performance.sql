
USE medicore_hospital;

-- Department Performance Analysis

SELECT
    d.department_name,

    COUNT(a.admission_id) AS total_admissions,

    COUNT(DISTINCT a.patient_id) AS unique_patients,

    SUM(CASE
        WHEN a.admission_type = 'Emergency' THEN 1
        ELSE 0
    END) AS emergency_admissions,

    SUM(CASE
        WHEN a.admission_type = 'Scheduled' THEN 1
        ELSE 0
    END) AS scheduled_admissions,

    ROUND(AVG(a.length_of_stay_days), 2)
        AS avg_length_of_stay,

    ROUND(AVG(a.readmitted_within_30_days) * 100, 2)
        AS readmission_rate_pct,

    ROUND(SUM(b.total_bill_amount), 2)
        AS total_billing_revenue

FROM admissions a

JOIN departments d
    ON a.department_id = d.department_id

LEFT JOIN billing b
    ON a.admission_id = b.admission_id

GROUP BY
    d.department_id,
    d.department_name

ORDER BY total_admissions DESC;

