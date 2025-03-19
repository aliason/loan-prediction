# Loan Prediction Machine Learning Project

## Project Description 
This repository contains the code for the final course project of PSTAT 131 (Statistical Machine Learning) at UCSB. Students are tasked with building machine learning models to solve a real-world problem of their choosing, utilizing R Markdown to generate a coherent report of key insights and findings.

My project tackles a binary classification problem: predicting loan eligibility based on select applicant data. I take a structured and analytical approach, incrementally traversing the data science life cycle and leveraging multiple techniques to yield the best model for the problem. 

Data are pulled from [Kaggle](https://www.kaggle.com/datasets/vikasukani/loan-eligible-dataset) (originally sourced from an [Analytics Vidhya Hackathon](https://datahack.analyticsvidhya.com/contest/practice-problem-loan-prediction-iii/#ProblemStatement). 

## Problem Statement
Loans are a necessity of the modern world, supporting financial stability and driving economic growth. Many types loans exist for different purposes, among which are home loans, which we intend to tackle in this problem. 

Dream Housing Finance company deals in all home loans. They have a presence across all urban, semi-urban, and rural areas. Customers first apply for a home loan, after which the company assesses their eligibility. 

The company aims to automate the loan eligibility process (real-time) based on customer details, such as gender, marital status, education, and income, provided in their application form. 

The goal of this project is to identify customer segments that are most likely to be eligible for home loans, enabling the company to target these segments more efficiently. The company have provided a partial dataset to support the development of this model. 

## Data Sources
The data files provided consists of a training set (train.csv) and test set (test.csv.). The test is identical to the training set except for the loan status to be predicted. The training set consists of 614 observations on 13 variables; the test set consists of 367 observations on 12. 

As my project will apply supervised learning methods, I will only be using the training set. I will perform a 70/30 split on train.csv and utilize the response values to assess predictive accuracy. 

## Project Roadmap  
The project will follow a structured approach, starting with data collection and processing, followed by exploratory analysis, model training, and evaluation.

First, I will load the dataset into R, examine its structure, and perform initial data tidying, addressing missing values, duplicates, and inconsistencies. Next, I conduct exploratory data analysis (EDA), analyzing variables one by one to identify relationships and covariability, using these insights to guide further preprocessing. The dataset undergoes final tidying before model development.

Next, I split the data into train vs. test sets (70/30), create a preprocessing recipe, and establish validation sets (10) to optimize model selection and tuning. Models are trained and stored in separate RDA files before being loaded back in for evaluation. Performance is evaluated based on ROC-AUC, and the top 3 selected for testing. The project concludes with a detailed summary of my takeaways and findings. 

## Methods used 
Techniques: 
* Data processing
    * Missing values (imputation via MICE)
    * Duplicates
    * Feature engineering
        * Scaling, discretization, and categorical encoding
    * Outlier detection
        * Log transformations 
* Data exploration 
    * Descriptive analysis 
    * Correlation analysis (heatmaps, corrplots)
    * Feature analysis 
    * Data visualization (histograms, barplots, scatterplots, etc.)
    * Inferential statistics (t-tests, ANOVA, regression) 
* Data modeling
    * Machine learning 
        * Logistic regression
        * Linear discriminant analysis (LDA) 
        * K-nearest neighbors (KNN)
        * Elastic net regression (Ridge) 
        * Quadratic discriminant analysis (QDA)
        * Pruned decision trees 
    * Resampling techniques  
        * Grid search 
        * K-fold cross-validation 
    * Model evaluation
        * Model evaluation metrics (ROC-AUC)
        * Confusion matrix 

Tools
* R (tidyverse, corrplot, ggplot2, dplyr, finalfit, MASS, MICE, kableExtra)
* Markdown (Rmd)
* Excel (codebook) 
