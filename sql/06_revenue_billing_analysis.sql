USE medicore_hospital;

-- Hospital Revenue and Billing Analysis

SELECT
    d.department_name,

    COUNT(b.bill_id) AS total_bills,

    ROUND(SUM(b.total_bill_amount), 2)
        AS total_billing_amount,

    ROUND(AVG(b.total_bill_amount), 2)
        AS avg_bill_amount,

    ROUND(SUM(b.insurance_amount), 2)
        AS total_insurance_amount,

    ROUND(SUM(b.patient_payable_amount), 2)
        AS total_patient_payable,

    SUM(CASE
        WHEN b.payment_status = 'Paid'
        THEN 1 ELSE 0
    END) AS paid_bills,

    SUM(CASE
        WHEN b.payment_status = 'Partially Paid'
        THEN 1 ELSE 0
    END) AS partially_paid_bills,

    SUM(CASE
        WHEN b.payment_status = 'Pending'
        THEN 1 ELSE 0
    END) AS pending_bills,

    ROUND(
        SUM(CASE
            WHEN b.payment_status = 'Pending'
            THEN b.total_bill_amount
            ELSE 0
        END), 2
    ) AS pending_billing_amount

FROM billing b

JOIN admissions a
    ON b.admission_id = a.admission_id

JOIN departments d
    ON a.department_id = d.department_id

GROUP BY
    d.department_id,
    d.department_name

ORDER BY total_billing_amount DESC;
