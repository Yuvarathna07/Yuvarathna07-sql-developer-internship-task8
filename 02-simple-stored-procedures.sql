-- Simple Stored Procedures Examples

DELIMITER //

-- 1. Simple Procedure with IN parameter - Get Employee by ID
CREATE PROCEDURE GetEmployee(IN emp_id INT)
BEGIN
    SELECT 
        id,
        name,
        email,
        salary,
        department,
        hire_date
    FROM employees 
    WHERE id = emp_id;
END //

-- 2. Procedure with IN and OUT parameters - Get Employee Count
CREATE PROCEDURE GetEmployeeCount(
    IN dept_name VARCHAR(50),
    OUT emp_count INT
)
BEGIN
    SELECT COUNT(*) INTO emp_count
    FROM employees 
    WHERE department = dept_name AND is_active = TRUE;
END //

-- 3. Procedure with conditional logic - Update Salary
CREATE PROCEDURE UpdateSalary(
    IN emp_id INT,
    IN new_salary DECIMAL(10,2),
    OUT message VARCHAR(255)
)
BEGIN
    DECLARE current_salary DECIMAL(10,2);
    DECLARE emp_exists INT DEFAULT 0;
    
    -- Check if employee exists
    SELECT COUNT(*), salary INTO emp_exists, current_salary
    FROM employees 
    WHERE id = emp_id;
    
    -- Conditional logic
    IF emp_exists = 0 THEN
        SET message = 'Employee not found';
    ELSEIF new_salary <= 0 THEN
        SET message = 'Salary must be greater than 0';
    ELSEIF new_salary > current_salary * 2 THEN
        SET message = 'Salary increase too high (max 100%)';
    ELSE
        UPDATE employees 
        SET salary = new_salary 
        WHERE id = emp_id;
        SET message = 'Salary updated successfully';
    END IF;
END //

-- 4. Simple procedure with loop - Calculate Total Payroll
CREATE PROCEDURE CalculateTotalPayroll(
    IN dept_name VARCHAR(50),
    OUT total_payroll DECIMAL(12,2)
)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE emp_salary DECIMAL(10,2);
    DECLARE running_total DECIMAL(12,2) DEFAULT 0;
    
    -- Cursor to get all salaries in department
    DECLARE salary_cursor CURSOR FOR 
        SELECT salary FROM employees 
        WHERE department = dept_name AND is_active = TRUE;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN salary_cursor;
    
    payroll_loop: LOOP
        FETCH salary_cursor INTO emp_salary;
        IF done THEN
            LEAVE payroll_loop;
        END IF;
        SET running_total = running_total + emp_salary;
    END LOOP;
    
    CLOSE salary_cursor;
    SET total_payroll = running_total;
END //

DELIMITER ;
