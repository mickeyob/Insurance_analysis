🩺 Medical Insurance Cost Analysis — Python | MySQL | Power BI
📘 Project Overview
This project explores the Kaggle Medical Insurance Dataset to uncover the main factors that influence insurance charges, such as age, BMI, smoking status, family size, and region.
The goal is to understand cost drivers, predict high-risk groups, and support strategic pricing and policy decisions for insurance companies.
The workflow covers the entire data analytics pipeline:
1.	Data cleaning and feature engineering in Python (Jupyter Notebook)
2.	Analytical queries in MySQL
3.	Interactive visualization and storytelling in Power BI
🧩 Business Problem Statement
A health insurance provider wants to better understand the key factors driving customer medical costs to improve pricing accuracy, profitability, and risk management.
They have noticed large variations in charges across different demographics and lifestyle factors (e.g., smokers vs. non-smokers, obesity levels, family size).
You are tasked with answering the question:
“How can demographic, lifestyle, and regional data be used to understand and manage the drivers of medical insurance costs?”
🧮 Dataset Summary
Source: Kaggle – Medical Cost Personal Dataset
Rows: 1,338 | Columns: 7
Column	Description
age	Age of the insured person
sex	Gender (male/female)
bmi	Body Mass Index
children	Number of dependents
smoker	Smoking status
region	Residential region (northeast, northwest, southeast, southwest)
charges	Medical insurance cost (in USD)
Feature Engineering:
•	age_group: Categorized into Young Adult, Adult, Middle-aged, Senior
•	bmi_group: Categorized into Underweight, Normal, Overweight, Obese
•	children_group: Categorized into No Children, Small Family (1–2), Medium Family (3–4), Large Family (5+)
🧰 Tools & Technologies
Stage	Tool	Purpose
Data Preparation	Python (pandas, seaborn, matplotlib)	Cleaning, transformation, and exploratory analysis
Data Storage & Analysis	MySQL	Advanced analytical queries and aggregations
Visualization	Power BI	Dashboard for business insights
Environment	VS Code / Jupyter Notebook	Development and experimentation

🧹 Step 1: Data Preparation in Python
Performed using pandas and numpy inside Jupyter Notebook.
Key Steps
•	Loaded the raw dataset and inspected data types
•	Checked for missing values and handled outliers
•	Created derived columns: age_group, bmi_group, and children_group
•	Conducted EDA using matplotlib and seaborn to explore variable relationships
•	Exported the cleaned dataset to CSV for MySQL import

🗃️ Step 2: Data Analysis in MySQL
Connected to MySQL using SQLAlchemy in Jupyter Notebook and executed analytical queries.
Example SQL Queries
1️⃣ Average Charges by Smoking Status and Region
SELECT smoker, region, ROUND(AVG(charges),2) AS avg_charges
FROM insurance_data
GROUP BY smoker, region
ORDER BY avg_charges DESC;
2️⃣ Age Group vs Average Charges

SELECT age_group, ROUND(AVG(charges),2) AS avg_charges, COUNT(*) AS customers
FROM insurance_data
GROUP BY age_group
ORDER BY avg_charges DESC;

3️⃣ High-Risk Customers (Charges > $20,000)

SELECT age, bmi, smoker, region, charges
FROM insurance_data
WHERE charges > 20000
ORDER BY charges DESC;

4️⃣ Family Size and Cost Patterns

WITH children_group AS (
  SELECT *,
    CASE
      WHEN children = 0 THEN 'No Children'
      WHEN children BETWEEN 1 AND 2 THEN 'Small Family (1–2)'
      WHEN children BETWEEN 3 AND 4 THEN 'Medium Family (3–4)'
      ELSE 'Large Family (5+)'
    END AS children_group
  FROM insurance_data
)
SELECT region, children_group, ROUND(AVG(charges),2) AS avg_charge
FROM children_group
GROUP BY region, children_group
ORDER BY region, avg_charge DESC;

📊 Step 3: Dashboard in Power BI
The cleaned data was imported from MySQL into Power BI to create an interactive dashboard.
Key Visuals
Visual	Description
KPI Cards	Total Customers, Average Charges, Avg BMI, % Smokers
Histogram	Distribution of Charges
Bar Chart	Avg Charges by Smoking Status
Clustered Bar	Avg Charges by Region
Matrix	Avg Charges by Age Group × BMI Group (color formatted)
Treemap	Total Charges by Region and Smoking Status
Map	Geographic distribution of total charges

📈 Step 4: Key Insights
•	Smokers pay up to 3× higher charges than non-smokers.
•	BMI and smoking are the strongest predictors of high insurance cost.
•	Middle-aged adults contribute the most to total charges.
•	South-east region shows consistently higher average costs.
•	Reducing smoker population by 10% can lower total expected charges significantly.

💡 Step 5: Business Recommendations
1.	Risk-Based Pricing: Adjust premiums dynamically based on age, BMI, and smoking behavior.
2.	Preventive Health Programs: Incentivize healthy lifestyle adoption (e.g., non-smoker discounts).
3.	Targeted Interventions: Focus on high-BMI, middle-aged customers for health education.
4.	Regional Analysis: Review provider networks and regional cost disparities.
5.	Policy Optimization: Use predictive modeling for future cost estimation and claim management.

🧱 Repository Structure
📦 insurance_analysis
 ┣ 📂 data
 ┃ ┗ medical-charges.csv
 ┣ 📂 notebooks
 ┃ ┗ medical_insurance_analysis.ipynb
 ┣ 📂 sql
 ┃ ┗ insurance_cost_analysis_sql_querries.sql
 ┣ 📂 powerbi
 ┃ ┗ medical_insurance_analysis_dashboard.pbix
 ┣ 📄 README.md

⚙️ Setup Instructions
Prerequisites
•	Python 3.8+
•	MySQL 8+
•	Power BI Desktop
Installation
pip install pandas numpy matplotlib seaborn sqlalchemy pymysql
Run Notebook
jupyter notebook
Then open and execute insurance_analysis.ipynb.

🧠 Future Work
•	Build a predictive model for insurance charges using regression.
•	Automate ETL pipeline between Python → MySQL → Power BI.
•	Integrate customer segmentation and risk scoring dashboards.

👤 Author
Eyob H.
📧 [eyobhailemichaelwolde@gmail.com]
💼 https://www.linkedin.com/in/eyob-hailemichael-woldeyohanis-259b2b336

