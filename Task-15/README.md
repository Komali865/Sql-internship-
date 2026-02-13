-- =========================================
-- TASK 15: Window Functions
-- =========================================

DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_name VARCHAR(100),
    department VARCHAR(100),
    salary DECIMAL(10,2),
    joining_date DATE
);

-- Insert Sample Data
INSERT INTO employees (emp_name, department, salary, joining_date) VALUES
('Ishaa', 'IT', 60000, '2022-01-10'),
('Rahul', 'IT', 75000, '2021-03-15'),
('Sneha', 'IT', 60000, '2023-05-20'),
('Arjun', 'HR', 45000, '2020-07-01'),
('Priya', 'HR', 50000, '2022-09-12'),
('Kiran', 'Finance', 80000, '2019-11-25'),
('Meena', 'Finance', 70000, '2021-04-30');

-- =========================================
-- 1️⃣ ROW_NUMBER(): Unique ranking per department
-- =========================================

SELECT 
    emp_name,
    department,
    salary,
    ROW_NUMBER() OVER(PARTITION BY department ORDER BY salary DESC) AS row_num
FROM employees;

-- =========================================
-- 2️⃣ RANK() vs DENSE_RANK()
-- =========================================

SELECT 
    emp_name,
    department,
    salary,
    RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS rank_value,
    DENSE_RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS dense_rank_value
FROM employees;

-- =========================================
-- 3️⃣ Running Total Salary per Department
-- =========================================

SELECT 
    emp_name,
    department,
    salary,
    SUM(salary) OVER(
        PARTITION BY department 
        ORDER BY salary DESC
    ) AS running_total
FROM employees;

-- =========================================
-- 4️⃣ LAG() and LEAD() - Compare Salaries
-- =========================================

SELECT 
    emp_name,
    department,
    salary,
    LAG(salary) OVER(PARTITION BY department ORDER BY joining_date) AS previous_salary,
    LEAD(salary) OVER(PARTITION BY department ORDER BY joining_date) AS next_salary
FROM employees;

-- =========================================
-- 5️⃣ Using WHERE with Window Function (Subquery)
-- Example: Top 2 highest salary in each department
-- =========================================

SELECT *
FROM (
    SELECT 
        emp_name,
        department,
        salary,
        ROW_NUMBER() OVER(PARTITION BY department ORDER BY salary DESC) AS rn
    FROM employees
) ranked
WHERE rn <= 2;
