CREATE TABLE sales_data (
    order_id VARCHAR(50),
    order_date VARCHAR(50),
    ship_date VARCHAR(50),
    ship_mode VARCHAR(50),
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50),
    market VARCHAR(50),
    region VARCHAR(50),
    product_id VARCHAR(50),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name VARCHAR(255),
    sales INT,
    quantity INT,
    discount FLOAT,
    profit FLOAT,
    shipping_cost FLOAT,
    order_priority VARCHAR(50),
    year int
);



COPY sales_data
FROM '/Users/ztlab104/Desktop/databases/sql/SQL/Sales_Dataset.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM sales_data;


ALTER TABLE sales_data
ADD COLUMN order_date_converted DATE,
ADD COLUMN ship_date_converted DATE;


UPDATE sales_data
SET
  order_date_converted = TO_DATE(order_date, 'DD-MM-YYYY'),
  ship_date_converted = TO_DATE(ship_date, 'DD-MM-YYYY');


SELECT state, MAX(shipping_cost) AS ship_cost
FROM sales_data
GROUP BY state;

SELECT state, MAX(shipping_cost) AS ship_cost
FROM sales_data
GROUP BY state
ORDER BY ship_cost DESC;


SELECT state, MAX(shipping_cost) AS ship_cost
FROM sales_data
GROUP BY state
ORDER BY ship_cost DESC
LIMIT 3;

-- #3 rd highest in terms of Ship cost

SELECT *
FROM (
    SELECT *,
           DENSE_RANK() OVER (ORDER BY ship_cost DESC) AS rank_state
    FROM (
        SELECT state, MAX(shipping_cost) AS ship_cost
        FROM sales_data
        GROUP BY state
    ) AS temp
) AS final_temp
WHERE rank_state = 3;