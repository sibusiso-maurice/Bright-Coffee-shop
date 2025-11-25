SELECT*
FROM
  "COFFEE"."BRIGHT_COFFEE_SHOP"."BRIGHT"
LIMIT
  10;
---Exploritary Data Analysis--

  --Checking Store location
SELECT DISTINCT store_location,
FROM COFFEE.BRIGHT_COFFEE_SHOP.BRIGHT;

--Checking Number of products Categories--
SELECT DISTINCT product_category,
FROM COFFEE.BRIGHT_COFFEE_SHOP.BRIGHT;

--Checking Number of products Types--
SELECT DISTINCT product_type,
FROM COFFEE.BRIGHT_COFFEE_SHOP.BRIGHT;

----Checking Earliest date
SELECT MIN (transaction_date)AS first_operating_date
FROM COFFEE.BRIGHT_COFFEE_SHOP.BRIGHT;

----Checking last date
SELECT MAX (transaction_date)AS last_operating_date
FROM COFFEE.BRIGHT_COFFEE_SHOP.BRIGHT;

----Checking Earliest Time
SELECT MIN (transaction_time)AS earlist_operating_time
FROM COFFEE.BRIGHT_COFFEE_SHOP.BRIGHT;

----Checking Latest Time
SELECT Max (transaction_time)AS latest_operating_time
FROM COFFEE.BRIGHT_COFFEE_SHOP.BRIGHT;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


  --FINDING TRANSATION DATE
  SELECT transaction_date,
  DAYNAME (transaction_date)AS day_name
  CASE WHEN 
  FROM COFFEE.BRIGHT_COFFEE_SHOP.BRIGHT;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---REVENUE-----

SELECT transaction_id,
transaction_qty*unit_price AS REVENUE
FROM COFFEE.BRIGHT_COFFEE_SHOP.BRIGHT;

--NUMBER OF SALES AND LOCATION
SELECT COUNT(transaction_id)AS  number_of_sales
FROM COFFEE.BRIGHT_COFFEE_SHOP.BRIGHT;

--Store location and store_id
SELECT DISTINCT store_location, store_id,
FROM COFFEE.BRIGHT_COFFEE_SHOP.BRIGHT;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---CALCULATING REVENUE BY STORE LOCATION
SELECT store_location,
SUM (transaction_qty*unit_price)AS REVENUE
FROM COFFEE.BRIGHT_COFFEE_SHOP.BRIGHT
GROUP BY store_location;


  ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT transaction_date,
  DAYNAME(transaction_date) AS day_name,
  CASE 
    WHEN DAYNAME(transaction_date) IN ('Saturday','Sunday') THEN 'Weekday'
    ELSE 'Weekend'
  END AS day_classification,
  MONTHNAME(transaction_date) AS month_name,
  TO_TIME(transaction_time) AS transaction_time,
  CASE
    WHEN TO_TIME(transaction_time) BETWEEN '06:00:00' AND '11:59:59' THEN 'MORNING'
    WHEN TO_TIME(transaction_time) BETWEEN '12:00:00' AND '16:59:59' THEN 'AFTERNOON'
    WHEN TO_TIME(transaction_time) BETWEEN '17:00:00' AND '23:59:59' THEN 'EVENING'
    ELSE 'NIGHT'
  END AS time_bucket,
  HOUR(transaction_time) AS hour_of_day,
  store_location,
  product_category,
  product_detail,
  unit_price,
  transaction_qty,
  product_type,
  COUNT(DISTINCT transaction_id) AS number_of_sales,
  SUM(transaction_qty * unit_price) AS Revenue
FROM COFFEE.BRIGHT_COFFEE_SHOP.BRIGHT
GROUP BY
  transaction_date,
  DAYNAME(transaction_date),
  MONTHNAME(transaction_date),
  TO_TIME(transaction_time),
  HOUR(transaction_time),
  store_location,
  product_category,
  product_detail,
  unit_price,
  transaction_qty,
  product_type
ORDER BY Revenue DESC;

SELECT transaction_date,
  DAYNAME(transaction_date) AS day_name,
  MONTHNAME(transaction_date) AS month_name,
  TO_TIME(transaction_time) AS transaction_time,
  HOUR(transaction_time) AS hour_of_day,
  store_location,
  product_category,
  product_detail,
  product_type,
  SUM(transaction_qty * unit_price) AS Revenue
FROM COFFEE.BRIGHT_COFFEE_SHOP.BRIGHT
GROUP BY
  transaction_date,
  DAYNAME(transaction_date),
  MONTHNAME(transaction_date),
  To_TIME(transaction_time),
  HOUR(transaction_time),
  store_location,
  product_category,
  product_detail,
  product_type
ORDER BY Revenue DESC;  
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--WHICH PRODUCTS GENERATES MORE REVENUE--------------
SELECT product_type,
    COUNT(*) AS transactions,
    SUM(unit_price) AS units_sold,
    SUM(transaction_qty * unit_price) AS total_revenue
FROM COFFEE.BRIGHT_COFFEE_SHOP.BRIGHT
GROUP BY product_type
ORDER BY total_revenue DESC;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--WHICH TIME OF THE times,days GENERATES MORE REVENUE AND TIMES USING TIME BUCKETS--

SELECT HOUR(transaction_time) AS hour_of_day,
  SUM(transaction_qty * unit_price) AS total_revenue,
  SUM(transaction_qty) AS total_units_sold,
  COUNT(DISTINCT DATE(transaction_date)) AS active_days
FROM COFFEE.BRIGHT_COFFEE_SHOP.BRIGHT
GROUP BY HOUR(transaction_time)
ORDER BY hour_of_day;

SELECT transaction_date,
  SUM(unit_price) AS revenue,
  SUM(transaction_qty) AS units_sold,
  COUNT(DISTINCT transaction_date) AS active_days
FROM COFFEE.BRIGHT_COFFEE_SHOP.BRIGHT
GROUP BY transaction_date
ORDER BY transaction_date;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Sales trend across products and time intervals
SELECT product_type,
  transaction_time,
  SUM(transaction_qty*unit_price) AS revenue
FROM COFFEE.BRIGHT_COFFEE_SHOP.BRIGHT
GROUP BY product_type, transaction_time
ORDER BY product_type, transaction_time;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Finding Minimum and Maximum Price
SELECT product_type,
  MIN(unit_price) AS minimum_price,
  MAX(unit_price) AS maximum_price
FROM COFFEE.BRIGHT_COFFEE_SHOP.BRIGHT
GROUP BY product_type
ORDER BY product_type;







