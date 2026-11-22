USE medicore_hospital;

-- Hospital Readmissions and Discharge Outcomes Analysis

SELECT
    d.department_name,

    COUNT(a.admission_id) AS total_admissions,

    SUM(
        CASE
            WHEN a.readmitted_within_30_days = 1 THEN 1
            ELSE 0
        END
    ) AS simulated_readmissions,

    ROUND(
        AVG(a.readmitted_within_30_days) * 100,
        2
    ) AS simulated_readmission_rate_pct,

    SUM(
        CASE
            WHEN a.discharge_disposition = 'Discharged Home' THEN 1
            ELSE 0
        END
    ) AS discharged_home,

    SUM(
        CASE
            WHEN a.discharge_disposition = 'Transferred' THEN 1
            ELSE 0
        END
    ) AS transferred,

    SUM(
        CASE
            WHEN a.discharge_disposition = 'Further Care' THEN 1
            ELSE 0
        END
    ) AS further_care,

    ROUND(
        AVG(a.length_of_stay_days),
        2
    ) AS avg_length_of_stay_days

FROM admissions a

JOIN departments d
    ON a.department_id = d.department_id

GROUP BY
    d.department_id,
    d.department_name

ORDER BY
    simulated_readmission_rate_pct DESC;