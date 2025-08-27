Project Overview

This project analyzes consumer behavior and sales patterns in a clothing store to provide actionable insights for marketing campaigns, inventory planning, and promotions. The analysis focuses on:

Identifying top and least purchased products

Examining seasonal trends per category

Exploring correlations between purchase amounts and customer demographics

Providing recommendations to optimize sales and inventory

Project Structure
consumer-behavior-sales-analysis/
│
├─ README.md
├─ sql/
│   └─ consumer_behavior_analysis.sql
    └─ exporting_results_to_tableau.sql
├─ data/
│   └─ dataset.csv
├─ visuals/
│   └─ category_distribution_by_gender.png
    └─ average_purchase_per_category.png
    └─ most_least_purchased_products.png
    └─ seasonal_sales_per_category.png


sql/ – Contains SQL queries used for the analysis

data/ – Dataset used in the project

visuals/ – Tableau dashboards and key charts


Key Analyses & Findings

Category Distribution by Gender

Men and women show very similar purchase behavior; ~45% buy clothing.

Minor difference in outerwear (~8%), which could be merged with clothing in future analysis.


Top & Least Sold Products

Top-selling items: Pants, Jewelry, Blouse (171 units each)

Least-selling: Jeans


Customers tend to prefer polished, professional styles.


Average Purchase Amount

Overall: $59.76 per customer

By category: Footwear $60.26, Clothing $60.03, Accessories $59.84, Outerwear $57.17

Prices are accessible, even for sophisticated items.


Seasonal Sales per Category

Clothing & Footwear peak in Spring

Accessories & Outerwear peak in Fall

Outerwear sales are lowest in Summer, suggesting the need for clearance campaigns.


Correlation Analysis

Variables such as age, previous purchases, and review ratings have negligible impact on purchase amount (R² < 0.03)

Seasonality and product categories are the main drivers of sales


Recommendations

Tailor marketing campaigns to polished/professional items while considering affordability.

Segment audience and run A/B tests if the goal is to boost casual item sales.

Align inventory and promotions with seasonal trends to maximize revenue.

Implement clearance strategies for Outerwear during low-demand seasons.


How to Use the SQL File

All SQL queries are in the sql/consumer_behavior_analysis.sql file

Queries are commented to explain the purpose of each analysis


Visuals

Tableau charts are saved in visuals/


Next Steps

Merge Outerwear with Clothing to refine category analysis

Explore additional customer attributes for deeper insights

Integrate sales data over multiple years for predictive seasonal planning
