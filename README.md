# Loan Prediction Machine Learning Project

## Project Description 
This repository contains the code for the final course project of PSTAT 131 (Statistical Machine Learning) at UCSB. Students apply machine learning algorithms to solve a real-world problem of their choosing and use Markdown to compile a concise report of key insights and findings.

My project tackles a binary classification problem: predict loan eligibility based on applicant demographics. I take a structured and analytical approach, incrementally traversing the data science life cycle and applying multiple techniques to identify the best model for the problem. 

Data are pulled from [Kaggle](https://www.kaggle.com/datasets/vikasukani/loan-eligible-dataset) (originally sourced from an [Analytics Vidhya Hackathon](https://datahack.analyticsvidhya.com/contest/practice-problem-loan-prediction-iii/#ProblemStatement). 

## Problem Statement
Loans are a necessity of the modern world, supporting finanical stability and economic growth. Many types of loans exist for different purposes, among which are home loans, which we will tackle in this problem. 

Dream Housing Finance company deals in all home loans, with a presence across urban, semi-urban, and rural areas. 

The company aims to automate their loan eligibility process (real-time) based on customer data, such as gender, marital status, education, and income, provided in their application form. 

The goal of this project is to identify customer segments that are most likely to be approved for home loans, leveraging these insights to optimize targeting. The company have provided a partial dataset to support the development of this model. 

## Data Sources
The files provided consist of a training (train.csv) and test set (test.csv.). The test set is identical to the training set except for the loan_status to be predicted. The training set consists of 614 observations on 13 variables; the test consists of 367 observations on 12. 

The test set will not be used in this project. I will only be applying supervised learning models in this project, which requires the response (loan_status) to be known. A 70/30 split will be performed on train.csv to assess predictive accuracy. 

## Project Roadmap  
The project will follow a structured approach, starting with data processing and cleaning, followed by data exploration, analysis, and modeling. 

First, I will load the dataset into R, examine its structure, and perform initial data tidying to address errors and inconsistencies. Next, I will conduct exploratory analysis (EDA), examining variables one by one to analyze relationships, trends, and variability. Insights derived from this step will guide further preprocessing. The dataset undergoes final tidying before modeling.

To begin: I perform a 70/30 (train/test) split, create a preprocessing recipe, and establish validation sets (10) to facilitate model selection and tuning. Models are trained in separate RDA files before being loaded back in for evaluation. Performance is evaluated on ROC-AUC, with the top 3 models selected for testing. The project concludes with a detailed summary of key takeaways and findings. 

## Methods used 
* Data processing
    * Missing values (imputation via MICE)
    * Duplicates
    * Data transformation
        * Scaling (standardization), binning, categorical encoding. 
        * Log transformation 
* Exploratory data analysis (EDA)
    * Distributional analysis (univariate + bivariate) 
    * Feature analysis 
    * Correlation analysis (heatmaps, corrplots)
    * Inferential statistics 
    * Data visualization (histograms, barplots, scatterplots)
* Data modeling
    * Algorithms: 
        * Logistic regression
        * Linear discriminant analysis (LDA) 
        * K-nearest neighbors (KNN)
        * Elastic net regression (Ridge) 
        * Quadratic discriminant analysis (QDA)
        * Pruned decision trees 
    * Resampling techniques: 
        * Grid search 
        * K-fold cross-validation 
    * Model evaluation: 
        * Evaluation metrics (ROC-AUC) 
        * Confusion matrix 
        * Lollipop plots (comparative) 

Tools
* R + Markdown: 
    * Visualization: ggplot2, ggthemes, corrplot, gridExtra, kableExtra
    * Analysis: tidyverse, dplyr, plyr, corrr, naniar, MASS, MICE
    * Modeling: tidymodels, discrim, klaR, pROC, yardstick, finalfit
* Excel (codebook)
