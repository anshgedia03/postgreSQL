-- Active: 1776843426475@@127.0.0.1@5432@employee
CREATE TABLE worker (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  department VARCHAR(50),
  salary DECIMAL(10,2),
  join_date DATE
);


INSERT INTO worker (name, department, salary, join_date)
VALUES
  ('Ansh', 'IT', 50000, '2024-01-10'),
  ('Rahul', 'HR', 40000, '2023-06-15'),
  ('Priya', 'Finance', 60000, '2022-09-20'),
  ('Amit', 'IT', 55000, '2024-03-01');

CREATE OR REPLACE FUNCTION get_worker_bonus(worker_salary DECIMAL)
RETURNS DECIMAL AS $$
BEGIN
  RETURN worker_salary * 0.10;
END;
$$ LANGUAGE plpgsql;

SELECT get_worker_bonus(50000);

CREATE OR REPLACE FUNCTION get_worker_name(
  worker_id INT,
  OUT worker_name TEXT
)
AS $$
BEGIN
  SELECT name
  INTO worker_name
  FROM worker
  WHERE id = worker_id;
END;
$$ LANGUAGE plpgsql;



SELECT  get_worker_name(1) as worker_name;



CREATE TYPE w_details AS (
  name VARCHAR(50),
  department VARCHAR(50),
  salary DECIMAL(10,2),
  join_date DATE
)

CREATE FUNCTION Get_worker_details(w_id INT)
RETURNS W_record AS $$
DECLARE 
w_record w_details;
BEGIN
SELECT name, department, salary, join_date
INTO w_record
FROM worker
WHERE id = w_id;
RETURN w_record;
END;
$$ LANGUAGE plpgsql;

SELECT Get_worker_details(1) as worker_details;


CREATE FUNCTION Get_worker_detail(w_id INT, OUT w_detail w_details)
AS $$
BEGIN
SELECT name, department, salary, join_date
INTO w_detail
FROM worker
WHERE id = w_id;
END;
$$ LANGUAGE plpgsql;


SELECT get_worker_detail(1) as worker_detail;