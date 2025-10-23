show databases;
use insurance;

-- What is the average medical charge per customer by smoking status and region during the past policy year?-- 

SELECT smoker, region, ROUND(AVG(charges),2) AS avg_charge,
       COUNT(*) AS num_customers
FROM insurance_data
GROUP BY smoker, region
ORDER BY smoker, region;



-- How does age correlate with insurance charges, and what age group contributes the most to high-cost claims greater than 20000?-- 

WITH high_cost AS (
    SELECT age_group, charges
    FROM insurance_data
    WHERE charges > 20000
)
SELECT age_group,
       COUNT(*) AS high_cost_count,
       ROUND(AVG(charges),2) AS avg_charge,
       ROUND(100*COUNT(*)/SUM(COUNT(*)) OVER (),2) AS pct_of_high_cost
FROM high_cost
GROUP BY age_group
ORDER BY high_cost_count DESC;


-- Do BMI categories (underweight, normal, overweight, obese) significantly affect average insurance charges?--

SELECT bmi_group,
       ROUND(AVG(charges),2) AS avg_charge,
       ROUND(STDDEV_POP(charges),2) AS charge_stddev,
       COUNT(*) AS num_customers
FROM insurance_data
GROUP BY bmi_group
ORDER BY avg_charge DESC;


-- Which combination of factors (age, smoker, BMI) best predicts high charges (above $20,000)?--

WITH high_cost AS (
    SELECT age_group, smoker, bmi_group
    FROM insurance_data
    WHERE charges > 20000
)
SELECT age_group, smoker, bmi_group,
       COUNT(*) AS high_cost_count,
       ROUND(COUNT(*)/SUM(COUNT(*)) OVER (),2) AS pct_high_cost
FROM high_cost
GROUP BY age_group, smoker, bmi_group
ORDER BY pct_high_cost DESC;


-- Can we estimate potential cost reduction if smoker prevalence is reduced by 10%?--

SELECT ROUND(AVG(charges) * 0.10 * COUNT(*),2) AS projected_savings,
       COUNT(*) AS smoker_count,
       ROUND(AVG(charges),2) AS avg_smoker_charge
FROM insurance_data
WHERE smoker = 'yes';


-- How does the number of children in a household affect average insurance charges across different regions over the past year?--  

WITH region_avg AS (
    SELECT region, ROUND(AVG(charges),2) AS region_avg
    FROM insurance_data
    GROUP BY region
)
SELECT 
    d.region, 
    CASE 
        WHEN d.children = 0 THEN 'No Children'
        WHEN d.children BETWEEN 1 AND 2 THEN 'Small Family'
        WHEN d.children BETWEEN 3 AND 4 THEN 'Medium Family'
        ELSE 'Large Family'
    END AS children_group,
    ROUND(AVG(d.charges),2) AS avg_charge,
    COUNT(*) AS num_customers,
    r.region_avg
FROM insurance_data d
JOIN region_avg r ON d.region = r.region
GROUP BY d.region, children_group, r.region_avg
ORDER BY d.region, 
         CASE 
            WHEN children_group = 'No/One Child' THEN 1
            WHEN children_group = 'Few Children' THEN 2
            ELSE 3
         END;



-- What is the trend of insurance charges across BMI categories for customers aged 30–50 in the last 12 months? --  

WITH age_subset AS (
    SELECT *
    FROM insurance_data
    WHERE age BETWEEN 30 AND 50
)
SELECT bmi_group,
       ROUND(AVG(charges),2) AS avg_charge,
       MIN(charges) AS min_charge,
       MAX(charges) AS max_charge,
       COUNT(*) AS num_customers
FROM age_subset
GROUP BY bmi_group
ORDER BY avg_charge DESC;


-- Which region has the highest proportion of high-cost claims (charges > $15,000) among smokers versus non-smokers in the past policy year? --  

SELECT region, smoker,
       ROUND(SUM(charges > 15000)/COUNT(*)*100,2) AS high_cost_pct,
       COUNT(*) AS total_customers,
       SUM(charges > 15000) AS high_cost_count
FROM insurance_data
GROUP BY region, smoker
ORDER BY high_cost_pct DESC;


-- How do insurance charges vary by gender within each BMI category for customers with 2 or more children? --  

SELECT sex, bmi_group,
       COUNT(*) AS num_customers,
       ROUND(AVG(charges),2) AS avg_charge,
       ROUND(MIN(charges),2) AS min_charge,
       ROUND(MAX(charges),2) AS max_charge
FROM insurance_data
WHERE children >= 2
GROUP BY sex, bmi_group
ORDER BY bmi_group, sex;



-- If average BMI for obese customers is reduced by 5% through wellness initiatives, what is the projected reduction in insurance charges for the next policy year? -- 

 --  Average charges for obese group -- 
 
 
WITH obese_charges AS (
    SELECT charges
    FROM insurance_data
    WHERE bmi_group = 'Obese'
)
SELECT ROUND(SUM(charges)*0.05,2) AS projected_reduction,
       COUNT(*) AS obese_customers,
       ROUND(AVG(charges),2) AS avg_charge
FROM obese_charges;


    
