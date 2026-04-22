CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name TEXT,
  email TEXT
);


INSERT INTO users (name, email)
VALUES ('Ansh2', 'ansh2@gmail.com');


SELECT * FROM users;

CREATE TABLE employee (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  email VARCHAR(100) UNIQUE,
  department VARCHAR(50),
  salary DECIMAL(10,2),
  hire_date DATE,
  is_active BOOLEAN DEFAULT TRUE
);


INSERT INTO employee (name, email, department, salary, hire_date)
VALUES
  ('Ansh Gedia', 'ansh@gmail.com', 'IT', 60000.00, '2024-01-15'),
  ('Rahul Sharma', 'rahul@gmail.com', 'HR', 45000.00, '2023-08-10'),
  ('Priya Patel', 'priya@gmail.com', 'Finance', 70000.50, '2022-05-20'),
  ('Amit Verma', 'amit@gmail.com', 'IT', 55000.75, '2024-03-01'),
  ('Neha Singh', 'neha@gmail.com', 'Marketing', 48000.00, '2023-11-12');


CREATE INDEX idx_email ON employee(email);
SELECT * FROM employee;


SELECT name from employee WHERE department='IT';
SELECT name from employee WHERE email='ansh@gmail.com';
SELECT name from employee WHERE email='ansh@gmail.com';

CREATE TABLE address (
  id SERIAL PRIMARY KEY,
  employee_id INT REFERENCES employee(id) ON DELETE CASCADE,
  city VARCHAR(50),
  state VARCHAR(50),
  country VARCHAR(50),
  pincode VARCHAR(10)
);

INSERT INTO address (employee_id, city, state, country, pincode)
VALUES
  (1, 'Mumbai', 'Maharashtra', 'India', '400001'),
  (2, 'Delhi', 'Delhi', 'India', '110001'),
  (3, 'Ahmedabad', 'Gujarat', 'India', '380001'),
  (4, 'Pune', 'Maharashtra', 'India', '411001'),
  (5, 'Bangalore', 'Karnataka', 'India', '560001');

SELECT 
  e.name AS employee_name,
  e.department AS dept,
  a.city AS location
FROM employee e
JOIN address a ON e.id = a.employee_id;


SELECT 
  name,
  salary
FROM employee
ORDER BY salary DESC;


SELECT 
  name,
  salary
FROM employee
ORDER BY salary DESC;


SELECT DISTINCT department
FROM employee;


SELECT
  name,
  department,
  salary
FROM employee
WHERE salary BETWEEN 50000 AND 70000;

SELECT
  name,
  hire_date
FROM employee
WHERE hire_date BETWEEN '2023-01-01' AND '2023-12-31';

SELECT
  name,
  department
FROM employee
WHERE department IN ('IT', 'Finance');


SELECT
  name,
  salary
FROM employee
ORDER BY salary DESC
LIMIT 3;

SELECT
  id,
  name,
  department
FROM employee
ORDER BY id
OFFSET 2;


SELECT
  id,
  name,
  department
FROM employee
ORDER BY id
LIMIT 2 OFFSET 2;

SELECT
  name,
  salary
FROM employee
ORDER BY salary DESC
FETCH FIRST 3 ROWS ONLY;


SELECT
  id,
  name,
  department
FROM employee
ORDER BY id
OFFSET 2 ROWS
FETCH NEXT 2 ROWS ONLY;


SELECT id,name,department,salary
FROM employee
WHERE department IN ('IT', 'Finance')
  AND salary BETWEEN 55000 AND 75000
ORDER BY salary DESC
LIMIT 2 OFFSET 0;
