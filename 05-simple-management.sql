-- Simple Management and Testing

-- Show all procedures and functions
SELECT 
    ROUTINE_NAME as name,
    ROUTINE_TYPE as type,
    CREATED as created_date
FROM INFORMATION_SCHEMA.ROUTINES 
WHERE ROUTINE_SCHEMA = DATABASE()
ORDER BY ROUTINE_TYPE, ROUTINE_NAME;

-- Test all procedures
SELECT 'Testing GetEmployee procedure:' as test;
CALL GetEmployee(1);

SELECT 'Testing GetEmployeeCount procedure:' as test;
CALL GetEmployeeCount('IT', @count);
SELECT @count as result;

SELECT 'Testing UpdateSalary procedure:' as test;
CALL UpdateSalary(2, 62000, @msg);
SELECT @msg as result;

SELECT 'Testing CalculateTotalPayroll procedure:' as test;
CALL CalculateTotalPayroll('HR', @total);
SELECT @total as result;

-- Test all functions
SELECT 'Testing all functions:' as test;
SELECT 
    id,
    name,
    GetAnnualSalary(id) as annual_salary,
    CalculateBonus(id, 10) as bonus,
    FormatName(id, 'UPPER') as upper_name,
    GetEmployeeStatus(id) as status
FROM employees
LIMIT 3;

-- Drop procedures and functions (if needed)
-- DROP PROCEDURE IF EXISTS GetEmployee;
-- DROP PROCEDURE IF EXISTS GetEmployeeCount;
-- DROP PROCEDURE IF EXISTS UpdateSalary;
-- DROP PROCEDURE IF EXISTS CalculateTotalPayroll;
-- DROP FUNCTION IF EXISTS GetAnnualSalary;
-- DROP FUNCTION IF EXISTS CalculateBonus;
-- DROP FUNCTION IF EXISTS FormatName;
-- DROP FUNCTION IF EXISTS GetEmployeeStatus;
