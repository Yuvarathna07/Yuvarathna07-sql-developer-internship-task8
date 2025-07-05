# Simple MySQL Stored Procedures and Functions - Task 8

## 📋 Project Overview
This is a simple MySQL project demonstrating stored procedures and functions for SQL Developer Internship Task 8.

## 🎯 What's Included
- ✅ **4 Stored Procedures** with different parameter types
- ✅ **4 Functions** with conditional logic
- ✅ **Simple database** with employees and departments
- ✅ **Easy examples** and usage

## 🚀 Quick Setup
1. Create database: `CREATE DATABASE simple_company;`
2. Use database: `USE simple_company;`
3. Run scripts in order: 01 → 02 → 03 → 04 → 05

## 📊 Database Tables
- **employees**: id, name, email, salary, department, hire_date, is_active
- **departments**: id, name, budget

## 🔧 Stored Procedures

### 1. GetEmployee(IN emp_id INT)
Gets employee information by ID
\`\`\`sql
CALL GetEmployee(1);
\`\`\`

### 2. GetEmployeeCount(IN dept_name VARCHAR, OUT emp_count INT)
Counts employees in a department
\`\`\`sql
CALL GetEmployeeCount('IT', @count);
SELECT @count;
\`\`\`

### 3. UpdateSalary(IN emp_id INT, IN new_salary DECIMAL, OUT message VARCHAR)
Updates employee salary with validation
\`\`\`sql
CALL UpdateSalary(1, 55000, @result);
SELECT @result;
\`\`\`

### 4. CalculateTotalPayroll(IN dept_name VARCHAR, OUT total_payroll DECIMAL)
Calculates total payroll for department using loop
\`\`\`sql
CALL CalculateTotalPayroll('IT', @total);
SELECT @total;
\`\`\`

## ⚙️ Functions

### 1. GetAnnualSalary(emp_id INT) RETURNS DECIMAL
Calculates annual salary (monthly × 12)
\`\`\`sql
SELECT GetAnnualSalary(1);
\`\`\`

### 2. CalculateBonus(emp_id INT, bonus_percent DECIMAL) RETURNS DECIMAL
Calculates bonus based on years worked
\`\`\`sql
SELECT CalculateBonus(1, 10);
\`\`\`

### 3. FormatName(emp_id INT, format_type VARCHAR) RETURNS VARCHAR
Formats employee name (UPPER, LOWER, FIRST)
\`\`\`sql
SELECT FormatName(1, 'UPPER');
\`\`\`

### 4. GetEmployeeStatus(emp_id INT) RETURNS VARCHAR
Returns employee status based on salary and experience
\`\`\`sql
SELECT GetEmployeeStatus(1);
\`\`\`

## 🎤 Interview Questions Answered

### 1. Difference between procedure and function?
- **Procedure**: Called with CALL, can have multiple outputs, can modify data
- **Function**: Used in SELECT, returns single value, shouldn't modify data

### 2. What is IN/OUT parameter?
- **IN**: Input parameter (value goes into procedure)
- **OUT**: Output parameter (value comes out of procedure)

### 3. Can functions return tables?
- No, MySQL functions return single values only
- Use procedures for multiple rows/columns

### 4. What is RETURN used for?
- In functions: specifies the value to return
- In procedures: exits the procedure early (optional)

### 5. How to call stored procedures?
\`\`\`sql
CALL procedure_name(parameters);
\`\`\`

### 6. What is the benefit of stored routines?
- Reusable code
- Better performance
- Centralized business logic
- Security (controlled access)

### 7. Can procedures have loops?
Yes! Example in CalculateTotalPayroll procedure:
\`\`\`sql
payroll_loop: LOOP
    FETCH cursor INTO variable;
    IF done THEN LEAVE payroll_loop; END IF;
    -- process data
END LOOP;
\`\`\`

### 8. Difference between scalar and table-valued functions?
- **Scalar**: Returns single value (what MySQL supports)
- **Table-valued**: Returns table (not supported in MySQL)

### 9. What is a trigger?
- Special procedure that runs automatically on INSERT/UPDATE/DELETE
- Cannot be called directly

### 10. How to debug stored procedures?
- Use SELECT statements to print values
- Check procedure syntax
- Use MySQL Workbench debugger

## 📝 Simple Usage Examples

\`\`\`sql
-- Get all employee info with bonuses
SELECT 
    name,
    salary,
    GetAnnualSalary(id) as yearly_salary,
    CalculateBonus(id, 10) as bonus,
    GetEmployeeStatus(id) as status
FROM employees;

-- Update salary and check result
CALL UpdateSalary(1, 60000, @msg);
SELECT @msg;

-- Get department totals
CALL CalculateTotalPayroll('IT', @it_total);
CALL CalculateTotalPayroll('HR', @hr_total);
SELECT @it_total as IT_Payroll, @hr_total as HR_Payroll;
\`\`\`

## ✅ Task Requirements Met
- [x] At least one stored procedure ✓ (4 procedures created)
- [x] At least one function ✓ (4 functions created)  
- [x] Use CREATE PROCEDURE and CREATE FUNCTION ✓
- [x] Use parameters and conditional logic ✓
- [x] Answer interview questions ✓

## 🎯 Files Structure
- `01-simple-database-setup.sql` - Database and sample data
- `02-simple-stored-procedures.sql` - 4 stored procedures
- `03-simple-functions.sql` - 4 functions
- `04-usage-examples.sql` - How to use everything
- `05-simple-management.sql` - Testing and management

**Ready for submission!** 🚀
