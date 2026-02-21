-- ===============================
-- DROP TABLES IF EXIST
-- ===============================

DROP TABLE IF EXISTS fact_sales;
DROP TABLE IF EXISTS dim_customer;
DROP TABLE IF EXISTS dim_product;
DROP TABLE IF EXISTS dim_date;


-- ===============================
-- DIMENSION TABLES
-- ===============================

-- CUSTOMER DIMENSION
CREATE TABLE dim_customer (
    customer_key SERIAL PRIMARY KEY,
    customer_id VARCHAR(20) UNIQUE,
    full_name VARCHAR(100),
    gender VARCHAR(10),
    date_of_birth DATE,
    city VARCHAR(50),
    state VARCHAR(50),
    region VARCHAR(50),
    signup_date DATE,
    customer_segment VARCHAR(30),
    loyalty_status VARCHAR(20),
    is_active INT
);


-- PRODUCT DIMENSION
CREATE TABLE dim_product (
    product_key SERIAL PRIMARY KEY,
    product_id VARCHAR(20) UNIQUE,
    product_name VARCHAR(100),
    product_category VARCHAR(50)
);


-- DATE DIMENSION
CREATE TABLE dim_date (
    date_key SERIAL PRIMARY KEY,
    full_date DATE,
    year INT,
    month INT,
    day INT,
    quarter INT
);


-- ===============================
-- FACT TABLE
-- ===============================

CREATE TABLE fact_sales (
    sales_key SERIAL PRIMARY KEY,
    order_id VARCHAR(30),
    customer_key INT,
    product_key INT,
    date_key INT,
    quantity INT,
    unit_price NUMERIC(10,2),
    total_sales NUMERIC(12,2),

    FOREIGN KEY (customer_key) REFERENCES dim_customer(customer_key),
    FOREIGN KEY (product_key) REFERENCES dim_product(product_key),
    FOREIGN KEY (date_key) REFERENCES dim_date(date_key)
);