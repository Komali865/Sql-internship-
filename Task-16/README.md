-- =====================================================
-- TASK 16: Case-Based SQL Analytics (Business Scenario)
-- =====================================================

-- Drop existing tables (Safe Re-run)
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;

-- =====================================================
-- 1️⃣ Create Tables
-- =====================================================

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(100),
    signup_date DATE
);

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(100),
    price DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- =====================================================
-- 2️⃣ Insert Realistic Transaction Data
-- =====================================================

INSERT INTO customers (customer_name, city, signup_date) VALUES
('Ishaa', 'Hyderabad', '2022-01-10'),
('Rahul', 'Mumbai', '2021-05-12'),
('Sneha', 'Delhi', '2023-02-18'),
('Arjun', 'Bangalore', '2020-07-01'),
('Priya', 'Chennai', '2021-09-22'),
('Kiran', 'Pune', '2022-11-05');

INSERT INTO products (product_name, category, price) VALUES
('Laptop', 'Electronics', 70000),
('Mobile', 'Electronics', 30000),
('Headphones', 'Accessories', 2000),
('Tablet', 'Electronics', 40000),
('Smartwatch', 'Accessories', 10000);

INSERT INTO orders (customer_id, product_id, quantity, order_date) VALUES
(1, 1, 1, '2023-01-15'),
(1, 3, 2, '2023-02-20'),
(2, 2, 1, '2023-03-05'),
(3, 1, 1, '2023-03-18'),
(4, 4, 1, '2023-04-10'),
(2, 5, 2, '2023-05-12'),
(5, 3, 3, '2023-06-25'),
(3, 2, 1, '2023-07-14');

-- =====================================================
-- 3️⃣ Top-Selling Products (By Revenue)
-- =====================================================

SELECT 
    p.product_name,
    SUM(o.quantity) AS total_units_sold,
    SUM(o.quantity * p.price) AS total_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC;

-- =====================================================
-- 4️⃣ Monthly Revenue Trends
-- =====================================================

SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(o.quantity * p.price) AS monthly_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY month
ORDER BY month;

-- =====================================================
-- 5️⃣ Inactive Customers (No Orders in 2023)
-- =====================================================

SELECT c.customer_id, c.customer_name
FROM customers c
LEFT JOIN orders o 
    ON c.customer_id = o.customer_id 
    AND YEAR(o.order_date) = 2023
WHERE o.order_id IS NULL;

-- =====================================================
-- 6️⃣ High-Value Customers (Spending > 80000)
-- =====================================================

SELECT 
    c.customer_name,
    SUM(o.quantity * p.price) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY c.customer_name
HAVING total_spent > 80000
ORDER BY total_spent DESC;

-- =====================================================
-- 7️⃣ Customer Lifetime Value Analytics
-- =====================================================

SELECT 
    c.customer_name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.quantity) AS total_items,
    IFNULL(SUM(o.quantity * p.price),0) AS lifetime_value
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
LEFT JOIN products p ON o.product_id = p.product_id
GROUP BY c.customer_name
ORDER BY lifetime_value DESC;

