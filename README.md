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
The raw dataset is read and examined, followed by initial data cleaning and transformation. Exploratory data analysis is performed using visualization and inferential techniques. Final tidying of the dataset is performed before setting up the models. The train.csv is split into a train and test set (70/30), a recipe is built, and validation sets are created to generate multiple estimates. Six supervised models are fit to the training set; each model's performance is evaluated based on several error metrics, and the top 3 are chosen for the test. Results of the best models are analyzed, and a summary of the project is provided. 

## Methods used 
* Statistical inference
* Feature selection 
* Feature engineering 
    * Imputation
    * Categorical encoding 
    * Standardization 
* Data visualization
* Resampling 
* Predictive modeling
    * Logistic regression
    * Linear discriminant analysis
    * K-nearest neighbors
    * Elastic net regression (Ridge) 
    * Quadratic discriminant analysis
    * Pruned decision trees 
