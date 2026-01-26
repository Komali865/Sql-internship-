CREATE DATABASE IF NOT EXISTS company_db;
USE company_db;

CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_name VARCHAR(100) NOT NULL,
    salary DECIMAL(10,2),
    department_id INT,
    
    CONSTRAINT fk_department
    FOREIGN KEY (department_id)
    REFERENCES departments(department_id)
    ON DELETE CASCADE
);
INSERT INTO departments (department_name) VALUES
('HR'),
('IT'),
('Finance');

INSERT INTO employees (employee_name, salary, department_id) VALUES
('Asha', 50000, 1),
('Rahul', 60000, 2),
('Sneha', 55000, 2),
('Vikram', 70000, 3);

SELECT * FROM departments;
SELECT * FROM employees;

-- 7. Attempt Invalid Foreign Key Insert (Will Fail)
-- Uncomment to test error
-- INSERT INTO employees (employee_name, salary, department_id)
-- VALUES ('InvalidEmp', 40000, 99);

DELETE FROM departments WHERE department_id = 2;

SELECT * FROM employees;
