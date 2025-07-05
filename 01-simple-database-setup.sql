-- Task 8: Simple MySQL Stored Procedures and Functions
-- Simple database setup

-- Create a simple employees table
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    salary DECIMAL(10,2) NOT NULL,
    department VARCHAR(50),
    hire_date DATE NOT NULL,
    is_active BOOLEAN DEFAULT TRUE
);

-- Create a simple departments table
CREATE TABLE departments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    budget DECIMAL(12,2)
);

-- Insert sample data
INSERT INTO departments (name, budget) VALUES
('IT', 100000.00),
('HR', 50000.00),
('Sales', 75000.00);

INSERT INTO employees (name, email, salary, department, hire_date) VALUES
('John Doe', 'john@company.com', 50000.00, 'IT', '2020-01-15'),
('Jane Smith', 'jane@company.com', 60000.00, 'HR', '2021-03-20'),
('Mike Johnson', 'mike@company.com', 55000.00, 'Sales', '2019-06-10'),
('Sarah Wilson', 'sarah@company.com', 65000.00, 'IT', '2022-02-28'),
('Tom Brown', 'tom@company.com', 45000.00, 'HR', '2023-01-10');
