CREATE DATABASE intern_db;
USE intern_db;

CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    age INT
);

INSERT INTO students (id, name, email, age) VALUES
(1, 'Rohan Kumar', 'rohan@gmail.com', 21),
(2, 'Priya Sharma', 'priya@gmail.com', 22),
(3, 'Aman Verma', 'aman@gmail.com', 20),
(4, 'Sneha Reddy', 'sneha@gmail.com', 23),
(5, 'Kiran Rao', 'kiran@gmail.com', 19);

SELECT * FROM students;
SELECT name, email FROM students;
SELECT name,age FROM students;
