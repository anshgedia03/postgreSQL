DROP TABLE IF EXISTS accounts;

CREATE TABLE accounts (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  balance DECIMAL(10,2)
);

INSERT INTO accounts (name, balance)
VALUES 
  ('Ansh', 5000),
  ('Rahul', 3000);

BEGIN;

-- Deduct from Ansh
UPDATE accounts 
SET balance = balance - 1000 
WHERE name = 'Ansh';

-- Add to Rahul
UPDATE accounts 
SET balance = balance + 1000 
WHERE name = 'Rahul';

COMMIT;



SELECT * FROM accounts;

BEGIN;

UPDATE accounts 
SET balance = balance - 1000 
WHERE name = 'Ansh';

-- Mistake (wrong column name)
UPDATE accounts 
SET balanc = balance + 1000 
WHERE name = 'Rahul';

ROLLBACK;