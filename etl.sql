drop table customers_dim,platform_dim,payment_dim

CREATE TABLE staging_orders (
order_id VARCHAR(50),
customer_id VARCHAR(50),
order_date DATE,
platform VARCHAR(50),
order_value_ngn FLOAT,
shipping_fee_ngn FLOAT,
payment_method VARCHAR(50),
payment_processor VARCHAR(50),
delivery_city VARCHAR(100),
delivery_status VARCHAR(50),
estimated_delivery_days INT,
order_status VARCHAR(50)
);

SELECT *
FROM staging_order


CREATE TABLE customer_dim(
customer_id VARCHAR(50) PRIMARY KEY,
customer_name VARCHAR(100),
customer_email VARCHAR(150),
customer_phone VARCHAR(50)
)
;

SELECT * 
FROM customer_dim 

CREATE TABLE platform_dim(
platform_id SERIAL PRIMARY KEY,
platform_name VARCHAR(100)
);


INSERT INTO platform_dim(platform_name)
SELECT DISTINCT platform 
FROM staging_order


SELECT * 
FROM platform_dim

CREATE TABLE payment_dim(
payment_id SERIAL PRIMARY KEY,
payment_method VARCHAR(100),
payment_processor VARCHAR(100)
);


INSERT INTO payment_dim(payment_method,payment_processor)
SELECT DISTINCT payment_method,payment_processor
FROM staging_order


SELECT * 
FROM payment_dim


CREATE TABLE delivery_dim(
delivery_id SERIAL PRIMARY KEY,
delivery_date DATE,
delivery_status VARCHAR(100),
delivery_city VARCHAR(100),
delivery_state VARCHAR(100)
);


INSERT INTO delivery_dim(delivery_status,delivery_city)
SELECT DISTINCT delivery_status,delivery_city
FROM staging_order



SELECT * 
FROM delivery_dim


CREATE TABLE time_dim(
time_id SERIAL PRIMARY KEY,
order_date DATE,
order_year INT,
order_quarter INT,
order_month INT,
order_day INT
);


INSERT INTO time_dim(order_date)
SELECT DISTINCT order_date
FROM staging_order

SELECT * 
FROM time_dim


CREATE TABLE fact_table(
order_id VARCHAR(50) PRIMARY KEY,
customer_id VARCHAR(50) REFERENCES customer_dim(customer_id),
platform_id INT REFERENCES platform_dim(platform_id),
payment_id INT REFERENCES payment_dim(payment_id),
delivery_id INT REFERENCES delivery_dim(delivery_id),
time_id INT REFERENCES time_dim(time_id),
order_value_ngn FLOAT,
shipping_fee_ngn FLOAT,
estimated_delivery_days INT,
order_status VARCHAR(50)
)

SELECT *
FROM fact_table


INSERT INTO fact_table (
    order_id,
    customer_id,
    platform_id,
    payment_id,
    delivery_id,
    time_id,
    order_value_ngn,
    shipping_fee_ngn,
    estimated_delivery_days,
    order_status
)

SELECT
    s.order_id,
    s.customer_id,
    p.platform_id,
    pay.payment_id,
    d.delivery_id,
    t.time_id,
    s.order_value_ngn,
    s.shipping_fee_ngn,
    s.estimated_delivery_days,
    s.order_status

FROM staging_order s

JOIN platform_dim p
ON s.platform = p.platform_name

JOIN payment_dim pay
ON s.payment_method = pay.payment_method
AND s.payment_processor = pay.payment_processor

JOIN delivery_dim d
ON s.delivery_city = d.delivery_city
AND s.delivery_status = d.delivery_status

JOIN time_dim t
ON s.order_date = t.order_date

ON CONFLICT (order_id) DO NOTHING;




UPDATE time_dim
SET
order_year = EXTRACT(YEAR FROM order_date),
order_quarter = EXTRACT(QUARTER FROM order_date),
order_month = EXTRACT(MONTH FROM order_date),
order_day = EXTRACT(DAY FROM order_date);

SELECT DISTINCT delivery_city
FROM delivery_dim
ORDER BY delivery_city;



SELECT *
FROM fact_table



