# Final_Project_Customer_Retention_E-Commerce
![Logo](https://github.com/yenle2092/Final_Project_Customer_Retention_E-Commerce/blob/main/Customer.JPG)

## Project Goal: 
The goal of this project is to analyze an e-commerce dataset to provide valuable insights into customer behavior and develop strategies for customer retention. Using unsupervised machine learning, specifically K-means clustering via the RFM model (Recency - Frequency - Monetary), I segment customers to better understand their preferences. Additionally, I employ supervised learning models to predict customer lifetime value, enabling the implementation of targeted retention strategies. My ultimate objective is to able to provide actionable recommendations to improve customer retention and increase customer loyalty.

## Dataset: Brazilian E-Commerce Dataset by Olist
The dataset has information of 100k orders from 2016 to 2018 made at multiple marketplaces in Brazil at Olist Store. Its features allows viewing an order from multiple dimensions: from order status, price, payment and freight performance to customer location, product attributes and reviews with 9 tables: customers, orders, items, produits, reviews, geolocation, payments, sellers. 

## Workflow:

### Data collection:  
I used the Kaggle API. It provides an easy-to-use command-line interface for searching for, selecting, and downloading Kaggle datasets: the Brazilian E-Commerce Public Dataset by Olist


### Data cleaning: 
- To begin, I first checked the overview of all tables in the dataset and chose 6 tables that were most relevant to the analysis for this project. I then deleted a few columns that contained information not necessarily related to the result of this project.

- Next, I handled the missing values in the selected tables to ensure the data was accurate and complete.

- After examining the data, I decided to choose only the data for 2017, as the data for 2016 and 2018 were incomplete.

- To ensure the data was not skewed by outliers, I executed a boxplot on the price and freight_value columns of the items table. I spotted and removed any outliers that were identified.

- To better analyze the data, I calculated the total amount of each order by adding the product price and freight value columns.

- Finally, I merged all the selected tables into one and removed any duplicates to produce the final dataset.

### EDA:
For EDA, some patterns were discovered in our dataset:

- Cohort Analysis of the number of retention customers and retention rate. This helped to identify trends in customer behavior and how often they return to make a purchase.

- Customer Retention KPIs: churn rate, repeat purchase ratio, monthly recurring revenue, time between purchases, and loyal customer rate. These metrics provide insight into customer behavior and help to identify areas for improvement in customer retention.

- Revenue per Month: the highest revenue occurred in November, which also had the highest number of customers. 

- Customer and Revenue by Location: identify the top 10 locations with the highest number of customers and the top 10 locations with the highest revenue ( top 2: Sao Paulo and Rio de Janeiro: biggest city in Brazil). 

- Produit Category : identify the top 10 categories with the highest number of product orders and the top 10 categories with the highest revenue. 

- Distribution of Review Scores: identify any patterns or trends in customer feedback. 

### Machine Learning Model: 
I used machine learning models to gain further insights into customer behavior and predict customer lifetime value (CLV).

- Unsupervised Learning Model : I used a K-means clustering model with k=4 to cluster customers based on their RFM metric (Recency - Frequency - Monetary) and gain insights into different customer segments.

- Supervised Machine Learning Models for CLV Prediction: I divided the dataset into train and test sets, with 80% of the data used for training and 20% for testing. I then used various supervised machine learning models to predict the customer lifetime value (CLV): 
    + Linear Regression
    + Support vector regression (SVR)
    + K-Neighbors Regression (KNN)

By comparing the performance of these models with Mean Squared Error	R-squared Score , I was able to select the best-fitted model for our dataset.

## Future Opportunities: 
- Churn Prediction: Identify churn rate as a key customer retention KPI. Developing a churn prediction model could help businesses identify customers who are at risk of leaving and implement targeted retention strategies.

- Product Recommendation: By analyzing customer purchase history and behavior, businesses can develop personalized product recommendations. Implementing a recommendation system could improve customer satisfaction and increase revenue

## Extra information: 
- Slide presentation: https://www.canva.com/design/DAFdWYBxbm8/wzvmwT7qqUcAU64y51Rltw/edit?utm_content=DAFdWYBxbm8&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton

- Project management Trello: https://trello.com/b/0eXVBfhA/finalproject-customer-retention#

![Trello](https://github.com/yenle2092/Final_Project_Customer_Retention_E-Commerce/blob/main/Trello_plan.JPG)




