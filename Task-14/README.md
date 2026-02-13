-- Create Table
DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    department VARCHAR(100) NOT NULL,
    salary DECIMAL(10,2) NOT NULL,
    bonus DECIMAL(10,2) DEFAULT 0,
    tax DECIMAL(10,2) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Drop Procedure if exists
DROP PROCEDURE IF EXISTS insert_employee;

-- Stored Procedure
CREATE PROCEDURE insert_employee(
    IN p_name VARCHAR(100),
    IN p_department VARCHAR(100),
    IN p_salary DECIMAL(10,2)
)
BEGIN
    IF p_salary <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary must be greater than 0';
    END IF;

    INSERT INTO employees(emp_name, department, salary)
    VALUES(p_name, p_department, p_salary);
END;

-- Drop Function if exists
DROP FUNCTION IF EXISTS calculate_tax;

-- Function: Tax
CREATE FUNCTION calculate_tax(p_salary DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE tax_amount DECIMAL(10,2);

    IF p_salary > 50000 THEN
        SET tax_amount = p_salary * 0.20;
    ELSE
        SET tax_amount = p_salary * 0.10;
    END IF;

    RETURN tax_amount;
END;

-- Drop Function if exists
DROP FUNCTION IF EXISTS calculate_bonus;

-- Function: Bonus
CREATE FUNCTION calculate_bonus(p_salary DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE bonus_amount DECIMAL(10,2);

    IF p_salary > 50000 THEN
        SET bonus_amount = p_salary * 0.15;
    ELSE
        SET bonus_amount = p_salary * 0.05;
    END IF;

    RETURN bonus_amount;
END;

-- Drop Procedure if exists
DROP PROCEDURE IF EXISTS update_salary_details;

-- Procedure to update tax & bonus
CREATE PROCEDURE update_salary_details()
BEGIN
    UPDATE employees
    SET 
        tax = calculate_tax(salary),
        bonus = calculate_bonus(salary);
END;

-- Insert Data
CALL insert_employee('Ishaa', 'IT', 60000);
CALL insert_employee('Rahul', 'HR', 45000);
CALL insert_employee('Sneha', 'Finance', 75000);

-- Update tax & bonus
CALL update_salary_details();

-- Final Output
SELECT * FROM employees;
