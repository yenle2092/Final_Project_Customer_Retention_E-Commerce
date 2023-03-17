CREATE DATABASE final_projects;

USE final_projects;

SELECT * FROM customers;
SELECT * FROM category_translation;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM items;
SELECT * FROM reviews;

## Create the final_data by joining 6 table and remove the duplicates 

CREATE TABLE final_data AS
SELECT DISTINCT * FROM
(SELECT c.customer_id, c.customer_unique_id, c.customer_city, c.customer_state, o.order_id, 
	    o.order_purchase_timestamp, i.order_item_id, i.product_id, i.price, i.freight_value, 
        r.review_score, ct.product_category_name_english
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
INNER JOIN items i ON o.order_id = i.order_id
INNER JOIN products p ON i.product_id = p.product_id
INNER JOIN reviews r ON i.order_id = r.order_id
INNER JOIN category_translation ct ON p.product_category_name = ct.product_category_name) data;
SELECT * FROM final_data;

## Add column total_amount = price + freight_ value in the final_data
ALTER TABLE final_data MODIFY price FLOAT,  #modify the datatype of the column price and freight_value
					   MODIFY freight_value FLOAT;
                       
ALTER TABLE final_data ADD COLUMN total_amount FLOAT;
UPDATE final_data SET total_amount = price + freight_value;
SELECT * FROM final_data;

## CREATE TABLE rfm_table (Recency - Frequency - Monetary)
ALTER TABLE final_data MODIFY order_purchase_timestamp DATE;

WITH  t1 AS (   ## Compute for F & M
    SELECT  
    DISTINCT
    customer_unique_id,
    MAX(order_purchase_timestamp) AS last_purchase_date,
    COUNT(DISTINCT order_id) AS Frequency,
    SUM(total_amount) AS Monetary 
    FROM final_data
    GROUP BY customer_unique_id
), 
t2 AS (    ## Compute for R
    SELECT *,
    DATEDIFF(reference_date, last_purchase_date) AS Recency
    FROM (
        SELECT  *,
        MAX(last_purchase_date) OVER () AS reference_date
        FROM t1
    )  AS sub1 
)
SELECT 
  customer_unique_id,
  Recency,
  Frequency,
  Monetary
FROM t2;



### 1 . Calculate Loyal Customer Ratio:

WITH loyal AS (
  SELECT 
    customer_unique_id,
    COUNT(DISTINCT order_id) AS number_order,
    SUM(total_amount) Sales
  FROM final_data
      GROUP BY customer_unique_id
)
SELECT 
  COUNT(DISTINCT customer_unique_id) AS total_customers,
  COUNT(DISTINCT IF(number_order >= 2, customer_unique_id, NULL)) as loyal_customers,
  COUNT(DISTINCT IF(number_order >= 2, customer_unique_id, NULL))/ COUNT(DISTINCT customer_unique_id) loyal_customer_ratio,
  SUM(IF(number_order >= 2, Sales,0))/COUNT(DISTINCT IF(number_order >= 2, customer_unique_id, NULL)) AS loyal_arpu ## average revenue par user
FROM loyal;

### 2. Top 10 state have the highest number of customers?

SELECT customer_state,
	   COUNT(customer_unique_id) AS "Number of customers"
FROM final_data
GROUP BY customer_state
ORDER BY COUNT(customer_unique_id) DESC
LIMIT 10;

## 3. Top 10 state have the highest revenue

SELECT customer_state,
	   ROUND(SUM(total_amount),2) AS "Revenue Total"
FROM final_data
GROUP BY customer_state
ORDER BY ROUND(SUM(total_amount),2) DESC
LIMIT 10;

## 4. Top 10 produit category have the highest produit order?

SELECT product_category_name_english AS "Product Category",
	   COUNT(order_item_id) AS "Number of order produits"
FROM final_data
GROUP BY product_category_name_english
ORDER BY COUNT(order_item_id) DESC
LIMIT 10;

## 5. Top 10 produit category have the highest revenue?

SELECT product_category_name_english AS "Product Category",
	   ROUND(SUM(total_amount),2) AS "Number of order produits"
FROM final_data
GROUP BY product_category_name_english
ORDER BY ROUND(SUM(total_amount),2) DESC
LIMIT 10;

## 6. Distribution of review_score: 

SELECT review_score,
	   COUNT(review_score) AS "Number of review"
FROM final_data
GROUP BY review_score
ORDER BY COUNT(review_score) DESC ;







