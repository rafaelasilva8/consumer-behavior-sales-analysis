-- Creating the table - only needed once

/*CREATE TABLE consumer_behavior (
    customer_id INT,
    age INT,
    gender VARCHAR(20),
    item_purchased VARCHAR(100),
    category VARCHAR(50),
    purchase_amount_usd NUMERIC(10,2),
    location VARCHAR(100),
    size VARCHAR(20),
    color VARCHAR(30),
    season VARCHAR(20),
    review_rating NUMERIC(3,2),
    subscription_status VARCHAR(20),
    shipping_type VARCHAR(50),
    discount_applied VARCHAR(10),
    promo_code_used VARCHAR(50),
    previous_purchases INT,
    payment_method VARCHAR(50),
    frequency_of_purchases VARCHAR(50)
);

COPY consumer_behavior(customer_id, age, gender, item_purchased, category, purchase_amount_usd,
	location, size, color, season, review_rating, subscription_status, shipping_type,
	discount_applied, promo_code_used, previous_purchases, payment_method, frequency_of_purchases)
FROM 'C:\Program Files\PostgreSQL\16\data\consumer_behavior.csv'
DELIMITER ','
CSV HEADER; */

-- Exploring a sample of the table
SELECT *
FROM sales
LIMIT 10;

	
-- Q1. How does category distribution vary across gender? 
-- 44.55% of females by accessories
-- 44.53 of males buy accessories
-- about 8% of males and females buy Outerwear
-- Seems like gender don't affect so much the category purchased

SELECT DISTINCT s1.category,

       -- Number of female customers in this category
       (SELECT COUNT(*)
        FROM sales AS s2
        WHERE s2.category = s1.category
          AND s2.gender = 'Female') AS female,

       -- Percentage of all women who bought this category
       ROUND(
         100.0 * (SELECT COUNT(*)
                  FROM sales AS s2
                  WHERE s2.category = s1.category
                    AND s2.gender = 'Female')
         / (SELECT COUNT(*)
            FROM sales
            WHERE gender = 'Female'), 2
       ) AS pct_of_all_females,

       -- Number of male customers in this category
       (SELECT COUNT(*)
        FROM sales AS s3
        WHERE s3.category = s1.category
          AND s3.gender = 'Male') AS male,

       -- Percentage of all men who bought this category
       ROUND(
         100.0 * (SELECT COUNT(*)
                  FROM sales AS s3
                  WHERE s3.category = s1.category
                    AND s3.gender = 'Male')
         / (SELECT COUNT(*)
            FROM sales
            WHERE gender = 'Male'), 2
       ) AS pct_of_all_males

FROM sales AS s1;


-- Q2. Which products were bought the most and least overall? 
-- Most bought - Jewelery, Pants and Blouse
-- Less bought - Jeans

SELECT 
    item_purchased,
    COUNT(*) AS purchase_count
FROM sales
GROUP BY item_purchased
ORDER BY purchase_count DESC;


-- Q3. What is the average purchase amount per customer 
-- $59.76
SELECT ROUND(AVG(purchase_amount_usd),2) AS avg_purchase
FROM sales

-- Q4. What is the average purchase amount per category
-- High Footwear - $60.26
-- Low Outerwear - $57.17
SELECT category, ROUND(AVG(purchase_amount_usd),2) AS avg_purchase
FROM sales
GROUP BY category
ORDER BY avg_purchase DESC;

-- Q5. Which seasons have the highest and lowest sales for each product category?
-- Hight - Spring - Clothing - $27,692.00
-- Low - Summer - Outerwear - $4,278.00
SELECT season, category, ROUND(SUM(purchase_amount_usd),2) AS total_sales
FROM sales
GROUP BY season, category
ORDER BY total_sales DESC;

-- Q6. The highest sales were clothes during spring and the lowest were Outerwear during Summer. 
-- What Items are in these categories? (first clothing)
-- Most types of clothing
SELECT DISTINCT (item_purchased)
FROM sales
WHERE category = 'Clothing';

-- Now Outerwear - Coats and Jackets (make sense being low in Summer)
SELECT DISTINCT(item_purchased)
FROM sales
WHERE category = 'Outerwear'

-- Q7. Is there a relationship between previous purchases and average spending? 
-- R-squared 0.008 - no correlation
SELECT
	CORR(previous_purchases, purchase_amount_usd)
FROM sales

-- Q8. What about between customer age and purchase amount? 
-- R-squared -0.010 - no correlation
SELECT
	CORR(age, purchase_amount_usd)
FROM sales

-- Q9. What about Review Rating vs purchase amount? 
-- R-squared 0.03 - weak correlation
SELECT
	CORR(review_rating, purchase_amount_usd)
FROM sales

