-- Simple Usage Examples

-- 1. Using Stored Procedures

-- Get employee information
CALL GetEmployee(1);

-- Get employee count by department
CALL GetEmployeeCount('IT', @count);
SELECT @count as IT_Employee_Count;

-- Update employee salary
CALL UpdateSalary(1, 55000, @result);
SELECT @result as Update_Result;

-- Calculate department payroll
CALL CalculateTotalPayroll('IT', @payroll);
SELECT @payroll as IT_Total_Payroll;

-- 2. Using Functions

-- Get annual salaries for all employees
SELECT 
    id,
    name,
    salary as monthly_salary,
    GetAnnualSalary(id) as annual_salary
FROM employees;

-- Calculate bonuses
SELECT 
    id,
    name,
    salary,
    CalculateBonus(id, 10) as ten_percent_bonus,
    CalculateBonus(id, 15) as fifteen_percent_bonus
FROM employees;

-- Format employee names
SELECT 
    id,
    FormatName(id, 'NORMAL') as normal_name,
    FormatName(id, 'UPPER') as upper_name,
    FormatName(id, 'FIRST') as first_name_only
FROM employees;

-- Get employee status
SELECT 
    id,
    name,
    salary,
    GetEmployeeStatus(id) as employee_status
FROM employees;

-- 3. Complex queries using both procedures and functions

-- Employee summary report
SELECT 
    e.id,
    e.name,
    e.department,
    e.salary,
    GetAnnualSalary(e.id) as annual_salary,
    CalculateBonus(e.id, 12) as annual_bonus,
    GetEmployeeStatus(e.id) as status
FROM employees e
WHERE e.is_active = TRUE
ORDER BY e.salary DESC;

-- Department summary
SELECT 
    d.name as department,
    COUNT(e.id) as employee_count,
    AVG(e.salary) as avg_salary,
    SUM(GetAnnualSalary(e.id)) as total_annual_payroll
FROM departments d
LEFT JOIN employees e ON d.name = e.department AND e.is_active = TRUE
GROUP BY d.name;
