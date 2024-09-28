# Loan Prediction Machine Learning Project

## Project Description 
This repository contains the code for the final course project of PSTAT 131 (Statistical Machine Learning) at the University of California, Santa Barbara taken in Winter 2023. Students are tasked with implementing machine learning techniques to execute predictive modeling, using R Markdown to generate a coherent report of figures, code, and key insights and findings. 

This project aims to develop a supervised learning model to predict loan eligibility based on select applicant demographics; a binary classification problem in which we predict whether a given loan will be approved or not. To this end, I will be conducting in-depth analysis of applicant profiles and implementing multiple techniques to yield the most accurate model for the problem. 

Data are pulled from [Kaggle](https://www.kaggle.com/datasets/vikasukani/loan-eligible-dataset) (originally sourced from an [Analytics Vidhya Hackathon](https://datahack.analyticsvidhya.com/contest/practice-problem-loan-prediction-iii/#ProblemStatement). 

## Problem Statement
Loans are a necessity of the modern world, supporting consumption, economic growth, and business operations. Many types loans exist for different purposes across various stages of life, among which are home loans, which we intend to tackle in this problem. 

Dream Housing Finance company deals in all home loans. They have a presence across all urban, semi-urban and rural areas. Customers can apply for a home loan after the company validates their eligibility. The company wants to automate the loan eligibility process (real-time) based on customer detail provided in their application. The company wants to identify customer segments that are eligible for loan amounts so that they can specifically target these customers.

## Dataset description
The data files provided consists of a training set (train.csv) and test set (test.csv), which is identical to the training set except for the loan status to be predicted. The training set consists of 614 observations on 13 variables; the testing consists of 367 observations on 12. 

Since this project only employs supervised learning, I will use only the training set. I will be performing a 70/30 split on the train.csv and utilize the response values to evaluate predictive accuracy. 

## Project outline 
First, I will import the raw dataset, examine its records, and perform initial data manipulation and cleaning. I will then conduct exploratory data analysis to visualize relationships and covariability, report my findings, and perform final tidying of the dataset before setting up the models. I split train.csv into a train and test set (70/30) and establish validation sets to facilitate model selection and tuning. I train, fit, and evaluate 6 classification models of varying complexity and flexibility, ranking them based on ROC-AUC. The top 3 are chosen for testing and fit to the test set. I compare, assess, and provide a thorough analysis of their performance and conclude with a detailed summary of my findings. 

## Methods used 
* Data collection 
* Data cleaning 
* Exploratory data analysis 
* Data visualization
* Feature engineering
    * Imputation
    * Categorical encoding
    * Standardization 
    * Resampling 
* Supervised learning 
    * Logistic regression
    * Linear discriminant analysis
    * K-nearest neighbors
    * Elastic net regression (Ridge) 
    * Quadratic discriminant analysis
    * Pruned decision trees 
* Model evaluation
    * K-fold cross-validation
    * ROC-AUC 
    * Confusion matrix 
