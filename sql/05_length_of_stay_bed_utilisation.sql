USE medicore_hospital;

-- Length of Stay and Estimated Bed Utilisation

SELECT
    d.department_name,

    d.bed_capacity,

    COUNT(a.admission_id) AS total_admissions,

    SUM(a.length_of_stay_days) AS total_occupied_bed_days,

    ROUND(AVG(a.length_of_stay_days), 2)
        AS avg_length_of_stay_days,

    MAX(a.length_of_stay_days)
        AS maximum_length_of_stay_days,

    ROUND(
        SUM(a.length_of_stay_days) * 100.0 /
        (d.bed_capacity * 731),
        2
    ) AS estimated_bed_occupancy_pct

FROM departments d

LEFT JOIN admissions a
    ON d.department_id = a.department_id

GROUP BY
    d.department_id,
    d.department_name,
    d.bed_capacity

ORDER BY estimated_bed_occupancy_pct DESC;
