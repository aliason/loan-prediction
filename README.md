# Loan Prediction Machine Learning Project

## Project Description 
This repository contains the code for the final course project of PSTAT 131 (Statistical Machine Learning) at the University of California, Santa Barbara taken in Winter 2023. Students are tasked with implementing machine learning techniques to execute predictive modeling, using R Markdown to generate a coherent report of figures, code, and key insights and findings. 

This project aims to develop a machine learning model that predicts the loan eligibility of customers based on information provided in their application profile; a binary classification problem in which we predict whether a given loan would be approved or not. To this end, I will build, train, and evaluate several supervised learning models, using R data science libraries (tidymodels, ggplot, dplyr) to facilitate data analysis and modeling. 

Data are pulled from [Kaggle](https://www.kaggle.com/datasets/vikasukani/loan-eligible-dataset) (originally sourced from an [Analytics Vidhya Hackathon](https://datahack.analyticsvidhya.com/contest/practice-problem-loan-prediction-iii/#ProblemStatement). 

## Problem Statement
Loans are a necessity of the modern world, supporting consumption, economic growth, and business operations. Many types loans exist for different purposes across various stages of life, among which are home loans, which we intend to tackle in this problem. 

Dream Housing Finance company deals in all home loans. They have a presence across all urban, semi-urban and rural areas. Customers can apply for a home loan after the company validates their eligibility. The company wants to automate the loan eligibility process (real-time) based on customer detail provided in their application. The company wants to identify customer segments that are eligible for loan amounts so that they can specifically target these customers.

## Dataset description
The data files provided consists of a training set (train.csv) and test set (test.csv), which is identical to the training set except for the loan status to be predicted. The training set consists of 614 observations on 13 variables; the testing consists of 367 observations on 12. 

Since this project only employs supervised learning, I will use only the training set. I will be performing a 70/30 split on the train.csv and utilize the response values to evaluate predictive accuracy. 

## Project outline 
First, I will import the raw dataset and examine its records to determine the necessary data cleaning and transformations to be performed. I will then conduct exploratory data analysis to visualize relationships and covariability, report my findings, and perform finaly tidying of the dataset before setting up the models. I then split the train.csv into a train and test set (70/30) and create validation sets to facilitate model selection and tuning. Six classification models of varying flexibility and complexity are fit to the training set and evaluated based on multiple performance metrics; the top 3 are chosen for testing. Finally, I will analyze and interpret the results of the best models, followed by a detailed conclusion of my findings. 

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
