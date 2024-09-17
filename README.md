# Loan Prediction Machine Learning Project

## Project Description 
This repository contains the code for the final course project of PSTAT 131 (Statistical Machine Learning) at the University of California, Santa Barbara taken in Spring 2023. 

The aim of this project is to develop a machine learning model that predicts the loan status of customers based on information provided in their application profile. It is a binary classification problem (a binary response) in which we predict whether a loan would be approved or not. I will be using open-source data pulled from [Kaggle](https://www.kaggle.com/datasets/vikasukani/loan-eligible-dataset) (pulled from an [Analytics Vidhya Hackathon](https://datahack.analyticsvidhya.com/contest/practice-problem-loan-prediction-iii/#ProblemStatement) and implementing multiple techniques to yield the most accurate model for the problem. 

The models will be implemented in R, utilizing several machine learning and data visualization libraries (tidymodels, ggplot, dplyr, gridExtra) to facilitate data processing, cleaning, and exploration.  

## Problem Statement
Loans are a necessity of the modern world, supporting consumption, economic growth, and business operations. Many types loans exist for different purposes across various stages of life, among which are home loans, which we intend to tackle in this problem. 

Dream Housing Finance company deals in all home loans. They have a presence across all urban, semi-urban and rural areas. Customers can apply for a home loan after the company validates their eligibility. The company wants to automate the loan eligibility process (real-time) based on customer detail provided in their application. The company wants to identify customer segments that are eligible for loan amounts so that they can specifically target these customers.

Loan prediction is a very common real-life problem that every retail bank faces at least once; automating this process could save time, resources, and money. There is, however, an unambiguously bias in lending. As such, we seek to examine the factors most predictive of loan status and fit multiple models to automate loan eligibility. 

## Dataset description
The data files provided consists of a training set (train.csv) and test set (test.csv), which contains similar data-points as train except for the loan status to be predicted. The training set consists of 614 observations on 13 variables (8 categorical and 5 numeric); the testing consists of 367 observations on 12. 

Since this project employs supervised learning methods, I intend to use only the training set. The dataset will be split into 70% training and 30% testing, using observed values to evaluate predictive accuracy. 

## Project outline 
First, I will load the data, perform initial data manipulation and cleaning, and address missing values. Next, I will perform exploratory data analysis, employing visualization and inferential techniques to identify trends, patterns, and relationships. After examining the data, I will perform some final tidying before setting up the models. I will split the train.csv into a train and test set (70/30), build a recipe, and create validation sets to generate multiple estimations of the test error rate. We then fit 6 supervised learning models (logistic, LDA, QDA, elastic net, KNN, and pruned decision trees) before assessing their performance using several evaluation metrics. From there, we will select the best model and fit it to our testing data.

## Methods used 
- Statistical inference
- Feature engineering
- Data visualization
- Predictive modeling
  + Supervised learning 
  + Model tuning
  + Cross-validation 
  + Evaluation metrics 
