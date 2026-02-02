CREATE DATABASE task11_perf;
USE task11_perf;

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    product_name VARCHAR(100),
    category VARCHAR(50),
    amount DECIMAL(10,2),
    status VARCHAR(20)
);

INSERT INTO orders (customer_id, order_date, product_name, category, amount, status)
SELECT 
    FLOOR(1 + RAND()*1000),
    DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND()*365) DAY),
    ELT(FLOOR(1 + RAND()*5),'Laptop','Phone','Tablet','Monitor','Keyboard'),
    ELT(FLOOR(1 + RAND()*3),'Electronics','Accessories','Office'),
    ROUND(RAND()*50000,2),
    ELT(FLOOR(1 + RAND()*3),'Shipped','Pending','Cancelled')
FROM information_schema.tables;

EXPLAIN SELECT * FROM orders WHERE customer_id = 500;

EXPLAIN SELECT * 
FROM orders 
WHERE category = 'Electronics'
ORDER BY order_date DESC;

-- Index for frequent search
CREATE INDEX idx_customer ON orders(customer_id);

-- Composite index for filter + sorting
CREATE INDEX idx_category_date ON orders(category, order_date);

-- Example 1 Again (Should use index)
EXPLAIN SELECT * FROM orders WHERE customer_id = 500;

-- Example 2 Again (Sorting optimized)
EXPLAIN SELECT * 
FROM orders 
WHERE category = 'Electronics'
ORDER BY order_date DESC;

-- Example 1: Function on column (index ignored)
EXPLAIN SELECT * FROM orders WHERE YEAR(order_date) = 2025;

-- Example 2: Low selectivity column
EXPLAIN SELECT * FROM orders WHERE status = 'Shipped';


