-- Active: 1776843426475@@127.0.0.1@5432@testdb
CREATE TABLE orders (
  id SERIAL,
  user_id INT,
  amount DECIMAL(10,2)
);

INSERT INTO orders (user_id, amount) VALUES
(1, 500),
(1, 700),
(2, 300),
(2, 200),
(3, 900);


CREATE VIEW demo_view AS 
SELECT * FROM orders;


CREATE MATERIALIZED VIEW user_total_spending AS
SELECT user_id, SUM(amount) AS total
FROM orders
GROUP BY user_id;

INSERT INTO orders VALUES (1, 1000);

SELECT * from user_spending_summary;

REFRESH MATERIALIZED VIEW user_spending_summary;


ALTER MATERIALIZED VIEW user_total_spending RENAME TO user_spending_summary;