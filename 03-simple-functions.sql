-- Simple MySQL Functions Examples

DELIMITER //

-- 1. Simple function - Calculate Annual Salary
CREATE FUNCTION GetAnnualSalary(emp_id INT) 
RETURNS DECIMAL(12,2)
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE annual_salary DECIMAL(12,2);
    
    SELECT salary * 12 INTO annual_salary
    FROM employees 
    WHERE id = emp_id;
    
    -- Return 0 if employee not found
    IF annual_salary IS NULL THEN
        SET annual_salary = 0;
    END IF;
    
    RETURN annual_salary;
END //

-- 2. Function with conditional logic - Calculate Bonus
CREATE FUNCTION CalculateBonus(emp_id INT, bonus_percent DECIMAL(5,2)) 
RETURNS DECIMAL(10,2)
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE emp_salary DECIMAL(10,2);
    DECLARE years_worked INT;
    DECLARE bonus_amount DECIMAL(10,2);
    
    -- Get employee salary and years worked
    SELECT 
        salary,
        YEAR(CURDATE()) - YEAR(hire_date)
    INTO emp_salary, years_worked
    FROM employees 
    WHERE id = emp_id;
    
    -- Return 0 if employee not found
    IF emp_salary IS NULL THEN
        RETURN 0;
    END IF;
    
    -- Calculate bonus with conditional logic
    IF years_worked >= 5 THEN
        SET bonus_amount = emp_salary * (bonus_percent + 2) / 100;  -- Extra 2% for long service
    ELSEIF years_worked >= 2 THEN
        SET bonus_amount = emp_salary * bonus_percent / 100;
    ELSE
        SET bonus_amount = emp_salary * (bonus_percent / 2) / 100;  -- Half bonus for new employees
    END IF;
    
    RETURN ROUND(bonus_amount, 2);
END //

-- 3. Simple string function - Format Employee Name
CREATE FUNCTION FormatName(emp_id INT, format_type VARCHAR(10)) 
RETURNS VARCHAR(255)
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE emp_name VARCHAR(100);
    DECLARE formatted_name VARCHAR(255);
    
    SELECT name INTO emp_name
    FROM employees 
    WHERE id = emp_id;
    
    IF emp_name IS NULL THEN
        RETURN 'Employee Not Found';
    END IF;
    
    -- Format based on type
    CASE UPPER(format_type)
        WHEN 'UPPER' THEN
            SET formatted_name = UPPER(emp_name);
        WHEN 'LOWER' THEN
            SET formatted_name = LOWER(emp_name);
        WHEN 'FIRST' THEN
            SET formatted_name = SUBSTRING_INDEX(emp_name, ' ', 1);
        ELSE
            SET formatted_name = emp_name;
    END CASE;
    
    RETURN formatted_name;
END //

-- 4. Function to check employee status
CREATE FUNCTION GetEmployeeStatus(emp_id INT) 
RETURNS VARCHAR(50)
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE emp_salary DECIMAL(10,2);
    DECLARE years_worked INT;
    DECLARE status_text VARCHAR(50);
    
    SELECT 
        salary,
        YEAR(CURDATE()) - YEAR(hire_date)
    INTO emp_salary, years_worked
    FROM employees 
    WHERE id = emp_id AND is_active = TRUE;
    
    IF emp_salary IS NULL THEN
        RETURN 'Employee Not Found';
    END IF;
    
    -- Determine status based on salary and experience
    IF emp_salary >= 60000 AND years_worked >= 3 THEN
        SET status_text = 'Senior Employee';
    ELSEIF emp_salary >= 50000 THEN
        SET status_text = 'Regular Employee';
    ELSE
        SET status_text = 'Junior Employee';
    END IF;
    
    RETURN status_text;
END //

DELIMITER ;
