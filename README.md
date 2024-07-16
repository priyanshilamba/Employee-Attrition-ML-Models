# Employee-Attrition-ML-Models

# Predictive Analytics: Predicting Employee Attrition


##  Overview
This project leverages machine learning to predict employee attrition for ABC Company, a leading organization that values its talented workforce. High employee turnover disrupts operations and incurs significant costs. By identifying employees at risk of leaving, ABC Company aims to retain top talent and maintain a thriving work environment.
## Problem Statement 
ABC Company faces high employee attrition, leading to operational disruptions, loss of institutional knowledge, and increased recruitment and training costs. The goal is to use data science to predict which employees are at risk of leaving and take proactive steps to retain them.
## Datasets and Variables
- Categorical Variables: Department, Education Field, Gender, Marital Status
- Numerical Variables: Age, Distance from workplace, Job Level, Monthly Income, Companies Worked, Salary Hike (%), Total Work Experience (Years), Years at Company, Years Since Last Promotion, Years with Current Manager
- Target Variable: Attrition (Yes/No)

## Data Cleaning and Processing
Handling Missing Values:

- Missing values in "YearsSinceLastPromotion" and "YearsWithCurrentManager" were imputed using the median.
Treating Outliers:

- Outliers in numerical features were identified and transformed using appropriate methods (square root, logarithm with offset). Introduced missing values were imputed again using the median.
Feature Engineering:

- Categorical variables were converted to factors.
Checking Assumptions:

- Ensured variables were normally distributed and investigated correlations between independent variables to check for multicollinearity.
Machine Learning Models

## Machine Learning Models
Logistic Regression:

- Accuracy: 84.79%
- High sensitivity (99.3%) but low specificity (9.2%).
  
Naive Bayes:

- Accuracy: 83.88%
- Perfect sensitivity but zero specificity.
  
Decision Tree:

- Accuracy: 85.02%
- Sensitivity: 0.9851, Specificity: 0.1479.
  
Random Forest:

- Accuracy: 99.32%
- Sensitivity: 0.9959, Specificity: 0.9789.
## Model Comparison
- Accuracy: Random Forest achieved the highest accuracy (99.32%).
- Sensitivity: All models showed high sensitivity.
- Specificity: Random Forest had the highest specificity (0.9789), indicating it accurately identifies employees at risk of leaving.
## Recommendation
- Leverage Model Predictions: Focus on employees with the highest predicted chance of leaving.
- Analyze Risk Factors: Identify specific factors contributing to potential departures.
- Targeted Interventions: Develop tailored solutions such as addressing workload concerns, offering training opportunities, or improving work-life balance options.
## Conclusion
This project demonstrates the effective use of predictive analytics to address high employee attrition, enabling ABC Company to proactively retain its top talent and enhance organizational stability.
