CREATE DATABASE medicore_hospital;
USE medicore_hospital;
SHOW tables;
USE medicore_hospital;

SELECT 'patients' AS table_name, COUNT(*) AS total_rows FROM patients
UNION ALL
SELECT 'departments', COUNT(*) FROM departments
UNION ALL
SELECT 'doctors', COUNT(*) FROM doctors
UNION ALL
SELECT 'admissions', COUNT(*) FROM admissions
UNION ALL
SELECT 'appointments', COUNT(*) FROM appointments
UNION ALL
SELECT 'billing', COUNT(*) FROM billing;