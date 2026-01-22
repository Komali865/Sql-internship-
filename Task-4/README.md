-- Create Database
CREATE DATABASE internship_db;
USE internship_db;

-- Create Table
CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    salary INT,
    experience INT
);

-- Insert Data
INSERT INTO employees (emp_name, department, salary, experience) VALUES
('Ravi', 'IT', 60000, 3),
('Anjali', 'HR', 45000, 2),
('Kiran', 'IT', 80000, 6),
('Sneha', 'Finance', 70000, 5),
('Arjun', 'IT', 50000, 2),
('Meena', 'HR', 40000, 1),
('Rahul', 'Finance', 90000, 7),
('Pooja', 'IT', 75000, 4);

-- 1. ORDER BY Ascending
SELECT * 
FROM employees
ORDER BY salary ASC;

-- 2. ORDER BY Descending
SELECT * 
FROM employees
ORDER BY salary DESC;

-- 3. Sorting Using Multiple Columns
SELECT * 
FROM employees
ORDER BY department ASC, salary DESC;

-- 4. LIMIT Top 3 Salaries
SELECT * 
FROM employees
ORDER BY salary DESC
LIMIT 3;

-- 5. WHERE + ORDER BY
SELECT * 
FROM employees
WHERE department = 'IT'
ORDER BY salary DESC;

-- 6. Pagination Using OFFSET (Page 1)
SELECT * 
FROM employees
ORDER BY emp_id
LIMIT 3 OFFSET 0;

-- 7. Pagination Using OFFSET (Page 2)
SELECT * 
FROM employees
ORDER BY emp_id
LIMIT 3 OFFSET 3;

-- 8. Leaderboard Style Query
SELECT emp_name, department, salary
FROM employees
ORDER BY salary DESC
LIMIT 5;

-- 9. Performance Optimized Query
SELECT emp_name, salary
FROM employees
WHERE salary > 50000
ORDER BY salary DESC
LIMIT 3;
