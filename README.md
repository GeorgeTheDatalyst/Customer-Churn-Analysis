## 🗄️ Database Setup & Data Loading

The dataset was imported into SQL Server using a custom table schema and `BULK INSERT` for efficient loading. This enabled structured querying and exploration during the EDA phase.

### 🧱 Table Schema

```sql
CREATE TABLE bank_churn (
  customer_id INT,
  credit_score INT, 
  country NVARCHAR(50),
  gender NVARCHAR(50),
  age INT,
  tenure INT,
  balance FLOAT,
  product_number INT,
  credit_card INT,
  active_member INT,
  estimated_salary FLOAT,
  churn INT
);
```
### 📥 Data Import

```sql
BULK INSERT bank_churn
FROM 'C:\Users\User\Desktop\customer churn\Bank Customer Churn Prediction.csv'
WITH (
  FIRSTROW = 2,
  FIELDTERMINATOR = ',',
  TABLOCK
);
```
## 🧼 Cleaned Table Schema

To support advanced segmentation and visualization, a cleaned version of the original dataset was created with additional categorical fields. This enhanced structure enables easier grouping and analysis in Power BI and SQL.

### 🧱 Table Definition

```sql
CREATE TABLE bank_churn_cleaned (
  customer_id INT,
  credit_score INT,
  credit_score_category NVARCHAR(50),
  country NVARCHAR(50),
  gender NVARCHAR(50),
  age INT,
  age_group NVARCHAR(50),
  tenure INT,
  balance FLOAT,
  balance_category NVARCHAR(50),
  product_category NVARCHAR(50),
  credit_card NVARCHAR(50),
  active_member NVARCHAR(50),
  estimated_salary FLOAT,
  churn NVARCHAR(50)
);
```
### 🧩 Enhancements
  Categorical columns like credit_score_category, age_group, balance_category, and product_category were derived from numerical fields to support grouped analysis.

  Boolean fields such as credit_card, active_member, and churn were converted to readable labels (Yes/No) for better dashboard clarity.

This cleaned table serves as the foundation for the churn analysis dashboard and supports more intuitive filtering and visualization.

## 🔄 Data Transformation & Clean Table Population

To enhance the dataset for analysis and visualization, categorical fields were derived from numerical values using SQL `CASE` statements. These transformations were used to populate the `bank_churn_cleaned` table.

### 📥 Insert Transformed Data

```sql
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
    WHEN balance > 10000 AND balance <= 50000 THEN '10K-50K'
    WHEN balance > 50000 AND balance <= 100000 THEN '50K-100K'
    WHEN balance > 100000 AND balance <= 150000 THEN '100K-150K'
    WHEN balance > 150000 AND balance <= 200000 THEN '150K-200K'
    ELSE 'Above 200K'
  END AS balance_category,
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
```

### 🧩 Purpose of Transformation
Enables segmentation by age, credit score, and balance ranges.

Improves readability in dashboards and reports.

Supports grouped analysis for churn prediction and customer profiling.

This cleaned and enriched dataset powers the visualizations and insights presented in the churn analysis dashboard.

## 🧪 Exploratory Data Analysis (EDA)

Initial data exploration was conducted using SQL to assess data quality, identify missing values, and understand feature distributions. The full EDA script is included separately in the repository under the `scripts/` folder.

Key checks included:
- Null value detection across critical fields (e.g., `customer_id`, `tenure`, `balance`, `product_number`, `credit_card`, `active_member`, `estimated_salary`, `churn`)
- Distribution analysis of categorical variables (`gender`, `country`, `product_number`)
- Age and balance range exploration to understand customer demographics

These insights informed the data cleaning process and guided feature engineering for churn modeling and dashboard design.

---
# PowerBI Connection.
This cleaned table was then connected to Power BI using the inbuilt data import funtionalities by connecting SQL Server with PowerBI for further analysis and visualization.

---
# 📊 Customer Churn Analysis

This project analyzes customer churn patterns in a banking dataset to uncover key drivers of attrition and support data-driven retention strategies. Using visualizations and segmentation, it highlights demographic and financial factors influencing churn.
---
--
View Project Live: https://app.powerbi.com/groups/me/reports/89aa65c5-1cbe-4940-898c-63b494d6bc00/f99b262ab094e4be0f74?experience=power-bi
--

## 🔍 Key Insights

- **Total Customers**: 10,000  
- **Churn Rate**: 20.4%  
- **Churned Customers**: 2,037

### 👥 Demographics
- **Gender**: Male (45.43%), Female (54.57%)
- **Activity Status**: Active (51.51%), Inactive (48.49%)

### 💳 Credit Card Ownership
- Owned: 70.55%  
- Not Owned: 29.45%

### 🌍 Geography
- France: 50.14%  
- Spain: 24.77%  
- Germany: 25.09%

### 🧾 Product Categories
- Product 1: 50.84%  
- Product 2: 45.9%  
- Product 3: 2.66%  
- Product 4: 0.6%

### 📈 Churn Trends
- **Age Groups**: Higher churn observed in 40–60 age range.
- **Credit Score**: Lower scores correlate with higher churn, with credit score of 200-400 having 100% churn rate.
- **Balance**: Customers with lower balances churn more frequently.

## 🧠 Strategic Recommendations
- Target inactive users with re-engagement campaigns.
- Develop tailored retention strategies for mid-age customers.
- Offer inclusive financial products for low credit score segments.
- Introduce loyalty programs for low-balance customers.

## 🛠️ Tools & Technologies# Customer-Churn-Analysis
This project analyzes customer behavior to identify patterns leading to churn. Using data preprocessing, segmentation, and predictive modeling, it uncovers key drivers of attrition and supports strategies to improve retention.
