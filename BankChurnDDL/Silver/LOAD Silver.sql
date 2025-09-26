INSERT INTO bank_churn_cleaned (
customer_id,
credit_score,
credit_score_category,
country,
gender,
age,
age_group,
tenure,
balance,
balance_category,
product_category,
credit_card,
active_member,
estimated_salary,
churn
)
SELECT
customer_id,
credit_score,
CASE 
WHEN credit_score BETWEEN 0 AND 200 THEN '0-200'
WHEN credit_score BETWEEN 201 AND 400 THEN '201-400'
WHEN credit_score BETWEEN 401 AND 600 THEN '401-600'
WHEN credit_score BETWEEN 601 AND 800 THEN '601-800'
WHEN credit_score BETWEEN 801 AND 1000 THEN '801-1000'
ELSE 'Above 1000' 
END AS credit_score_category,
country,
gender,
age,
CASE 
WHEN age BETWEEN 0 AND 40 THEN '0-40'
WHEN age BETWEEN 41 AND 60 THEN '41-60'
ELSE 'Above 60'
END AS age_group,
tenure,
balance,
CASE 
WHEN balance >= 0 AND balance <= 10000 THEN '0-10K'
WHEN balance >10000 AND balance <= 50000 THEN '10K-50K'
WHEN balance >50000 AND balance <=100000 THEN '50K-100K'
WHEN balance >100000 AND balance <= 150000 THEN '100K-150K'
WHEN balance > 150000 AND balance <= 200000 THEN '150K-200K'
ELSE 'Above 200K'
END AS balace_category,
CASE 
WHEN product_number = 1 THEN 'product 1'
WHEN product_number = 2 THEN 'product 2'
WHEN product_number = 3 THEN 'product 3'
WHEN product_number = 4 THEN 'product 4'
ELSE 'N/A'
END AS product_category,
CASE 
WHEN credit_card = 1 THEN 'owned'
WHEN credit_card = 0 THEN 'not owned'
ELSE 'N/A'
END AS credit_card,
CASE 
WHEN active_member = 1 THEN 'active'
WHEN active_member = 0 THEN 'inactive'
ELSE 'N/A'
END AS active_member,
estimated_salary,
CASE 
WHEN churn = 1 THEN 'churned'
WHEN churn = 0 THEN 'not churned'
ELSE 'N/A'
END AS churn
FROM bank_churn;
