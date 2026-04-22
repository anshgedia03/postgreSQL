-- Active: 1776843426475@@127.0.0.1@5432@employee
CREATE DATABASE employee;


CREATE TABLE employees (
  id SERIAL PRIMARY KEY,
  name TEXT,
  salary DECIMAL,
  updated_at TIMESTAMP
);

CREATE TABLE audit_log (
  id SERIAL,
  action TEXT,
  emp_id INT,
  action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION log_action()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit_log(action, emp_id)
  VALUES (TG_OP, NEW.id);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER after_insert_emp
AFTER INSERT ON employees
FOR EACH ROW
EXECUTE FUNCTION log_action();


INSERT INTO employees(name, salary) VALUES ('Ansh', 50000);


SELECT * FROM audit_log;


CREATE OR REPLACE FUNCTION check_salary()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.salary < 0 THEN
    RAISE EXCEPTION 'Salary cannot be negative';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_insert_emp
BEFORE INSERT ON employees
FOR EACH ROW
EXECUTE FUNCTION check_salary();




CREATE OR REPLACE FUNCTION prevent_delete()
RETURNS TRIGGER AS $$
BEGIN
  RAISE EXCEPTION 'Delete not allowed!';
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_delete_emp
BEFORE DELETE ON employees
FOR EACH ROW
EXECUTE FUNCTION prevent_delete();



CREATE OR REPLACE FUNCTION log_delete()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit_log(action, emp_id)
  VALUES ('DELETE', OLD.id);
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER after_delete_emp
AFTER DELETE ON employees
FOR EACH ROW
EXECUTE FUNCTION log_delete();



ALTER TRIGGER after_insert_emp ON employees
RENAME TO after_insert_employee;


DROP TRIGGER after_insert_employee ON employees;



ALTER TABLE employees DISABLE TRIGGER after_delete_emp;