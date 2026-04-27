-- Active: 1776843426475@@127.0.0.1@5432@employee
CREATE TABLE emp (
  id SERIAL PRIMARY KEY,
  fname VARCHAR(50),
  lname VARCHAR(50),
  salary DECIMAL(10,2),
  locations VARCHAR(100),
  age INT
);


INSERT INTO emp (fname, lname, salary, locations, age)
VALUES
  ('Ansh', 'Gedia', 50000, 'Mumbai', 22),
  ('Rahul', 'Sharma', 45000, 'Delhi', 25),
  ('Priya', 'Patel', 60000, 'Ahmedabad', 24),
  ('Amit', 'Verma', 55000, 'Pune', 27),
  ('Neha', 'Singh', 48000, 'Bangalore', 23);


SELECT * FROM emp;

CREATE TABLE budget (
    budget_id INT PRIMARY KEY DEFAULT 1,
    allocated_budget INT NOT NULL DEFAULT 1500000,
    used_budget INT NOT NULL DEFAULT 0,
    CHECK (used_budget <= allocated_budget)
);

INSERT INTO budget (budget_id, allocated_budget, used_budget)
VALUES (
    1,
    1500000,
    (SELECT COALESCE(SUM(salary), 0) FROM emp)
);

SELECT * FROM budget;

CREATE OR REPLACE FUNCTION update_budget_used_amount()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE budget
    SET used_budget = (SELECT COALESCE(SUM(salary), 0) FROM emp)
    WHERE budget_id = 1;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_emp_after_insert_budget
AFTER INSERT ON emp
FOR EACH ROW
EXECUTE FUNCTION update_budget_used_amount();

CREATE TRIGGER trg_emp_after_salary_update_budget
AFTER UPDATE OF salary ON emp
FOR EACH ROW
EXECUTE FUNCTION update_budget_used_amount();

CREATE TRIGGER trg_emp_after_delete_budget
AFTER DELETE ON emp
FOR EACH ROW
EXECUTE FUNCTION update_budget_used_amount();

INSERT INTO emp(fname, lname, salary, locations, age)
VALUES ('test', 'employee', 25000, 'BASERA', 21);

SELECT * FROM emp;
SELECT * FROM budget;

UPDATE emp
SET salary = 30000
WHERE fname = 'test'
  AND lname = 'employee';

SELECT * FROM emp;
SELECT * FROM budget;