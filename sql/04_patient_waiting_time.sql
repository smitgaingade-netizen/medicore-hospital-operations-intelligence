USE medicore_hospital;

-- Patient Waiting Time Analysis

SELECT
    d.department_name,

    COUNT(a.appointment_id) AS total_appointments,

    SUM(CASE
        WHEN a.appointment_status = 'Completed'
        THEN 1 ELSE 0
    END) AS completed_appointments,

    SUM(CASE
        WHEN a.appointment_status = 'Cancelled'
        THEN 1 ELSE 0
    END) AS cancelled_appointments,

    SUM(CASE
        WHEN a.appointment_status = 'No-show'
        THEN 1 ELSE 0
    END) AS no_show_appointments,

    ROUND(AVG(a.waiting_time_minutes), 2)
        AS avg_waiting_time_minutes,

    ROUND(AVG(
        CASE
            WHEN a.appointment_status = 'Completed'
            THEN a.waiting_time_minutes
        END
    ), 2) AS avg_completed_wait_minutes,

    ROUND(
        SUM(CASE
            WHEN a.appointment_status = 'No-show'
            THEN 1 ELSE 0
        END) * 100.0 / COUNT(a.appointment_id),
        2
    ) AS no_show_rate_pct

FROM appointments a

JOIN departments d
    ON a.department_id = d.department_id

GROUP BY
    d.department_id,
    d.department_name

ORDER BY avg_waiting_time_minutes DESC;
