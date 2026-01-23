CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(100) NOT NULL,
    department VARCHAR(50),
    salary DECIMAL(10,2),
    joining_date DATE,
    status VARCHAR(20) DEFAULT 'ACTIVE'
);
INSERT INTO employees (emp_name, department, salary, joining_date, status) VALUES
('Ravi Kumar', 'IT', 60000, '2023-01-15', 'ACTIVE'),
('Anita Sharma', 'HR', 45000, '2022-08-10', 'ACTIVE'),
('Suresh Reddy', 'Finance', 70000, '2021-05-20', 'ACTIVE'),
('Priya Singh', 'IT', 55000, '2023-03-12', 'ACTIVE'),
('Aman Verma', 'Sales', 40000, '2020-11-01', 'INACTIVE');

SELECT * FROM employees;

SELECT emp_id, emp_name, department, salary
FROM employees
WHERE department = 'IT'
AND salary > 50000;

UPDATE employees
SET salary = salary * 1.10
WHERE department = 'IT';

SELECT emp_name, department, salary
FROM employees;

SELECT * FROM employees
WHERE status = 'INACTIVE';

DELETE FROM employees
WHERE status = 'INACTIVE';

SELECT * FROM employees;

START TRANSACTION;

UPDATE employees
SET salary = salary + 5000
WHERE department = 'HR';

SELECT * FROM employees
WHERE department = 'HR';

ROLLBACK;

SELECT * FROM employees
WHERE department = 'HR';

DELETE FROM employees
WHERE emp_id = 3;

SELECT * FROM employees;
