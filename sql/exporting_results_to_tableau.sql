-- Q1. How does category distribution vary across gender? 

COPY (
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

FROM sales AS s1
) TO 'C:\Program Files\PostgreSQL\16\data\downloads/gender_distribution.csv'
WITH CSV HEADER;

-- Q2. Which products were bought the most and least overall? 
COPY (
SELECT 
    item_purchased,
    COUNT(*) AS purchase_count
FROM sales
GROUP BY item_purchased
ORDER BY purchase_count DESC
) TO 'C:\Program Files\PostgreSQL\16\data\downloads/products_bought.csv'
WITH CSV HEADER;

-- Q4. What is the average purchase amount per category
COPY (
SELECT category, ROUND(AVG(purchase_amount_usd),2) AS avg_purchase
FROM sales
GROUP BY category
ORDER BY avg_purchase DESC
) TO 'C:\Program Files\PostgreSQL\16\data\downloads/average_purch_category.csv'
WITH CSV HEADER;

-- Q5. Which seasons have the highest and lowest sales for each product category?
COPY (
SELECT season, category, ROUND(SUM(purchase_amount_usd),2) AS total_sales
FROM sales
GROUP BY season, category
ORDER BY total_sales DESC
) TO 'C:\Program Files\PostgreSQL\16\data\downloads/category_per_season.csv'
WITH CSV HEADER;

-- Q7. The highest sales were clothes during spring and the lowest were Outerwear during Summer. 
COPY (
SELECT
	CORR(previous_purchases, purchase_amount_usd)
FROM sales
) TO 'C:\Program Files\PostgreSQL\16\data\downloads/corr_prev.csv'
WITH CSV HEADER;

-- Q8. What about between customer age and purchase amount? 
COPY (
SELECT
	CORR(age, purchase_amount_usd)
FROM sales
) TO 'C:\Program Files\PostgreSQL\16\data\downloads/corr_age.csv'
WITH CSV HEADER;

-- Q9. What about Review Rating vs purchase amount? 
COPY (
SELECT
	CORR(review_rating, purchase_amount_usd)
FROM sales
) TO 'C:\Program Files\PostgreSQL\16\data\downloads/corr_review.csv'
WITH CSV HEADER;