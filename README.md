# Loan Prediction Machine Learning Project

## Project Description
This repository contains the code for the final course project of PSTAT 131 (Statistical Machine Learning) at UCSB. Students apply machine learning algorithms to solve a real-world problem of their choosing and use R Markdown to compile a report of key findings.

My project tackles a binary classification problem: predict loan eligibility based on applicant demographics. I take a structured and analytical approach, leveraging multiple techniques to identify the best model for the problem. 

Data are pulled from [Kaggle](https://www.kaggle.com/datasets/vikasukani/loan-eligible-dataset) (originally sourced from an [Analytics Vidhya Hackathon](https://datahack.analyticsvidhya.com/contest/practice-problem-loan-prediction-iii/#ProblemStatement))

## Data Sources
The project uses 2 files:
* `train.csv`: 614 observations, 13 variables 
* `test.csv`: 367 observations, 12 variables (excluding the target) 

Note that only `train.csv` will be used in this project. A 70/30 split is performed internally to support supervised learning and model evaluation. 

## Project Roadmap  
The project will follow a structured workflow, starting with data processing and cleaning, followed by exploration, analysis, and modeling.

First, I load the dataset into R, assess its structure, and perform initial data tidying to address inconsistencies. Next, I conduct exploratory data analysis (EDA), extracting insights to guide further preprocessing. The dataset undergoes final tidying before modeling.

Next, I perform a 70/30 split on `train.csv`, build a preprocessing recipe, and create 10 cross-validation sets for resampling. Models are trained and tuned in separate `.rda` files before being loaded back in for evaluation. The top 3 models are selected for testing and evaluated on ROC-AUC.

The project concludes with a detailed summary of key takeaways and findings. 

## Methods Used 
* Data processing
    * Missing data (imputation via MICE)
    * Duplicates
    * Feature transformation (scaling, binning, categorical encoding)
* EDA 
    * Visualization (histograms, barplots, scatterplots)
    * Feature analysis 
    * Correlation analysis (heatmaps, corrplots)
    * Inferential statistics 
* Data modeling
    * Models: logistic regression, LDA, KNN, QDA, elastic net (L2), pruned decision trees
    * Resampling: grid search, k-fold CV 
    * Evaluation: ROC-AUC, confusion matrix, lollipop plots
 
Tools
* R + libraries (`ggplot2`, `tidyverse`, `corrplot`, `MASS`, and more)
* R markdown
* Excel ([codebook](codebook.xlsx) with variable definitions)

## Notes 
GitHub doesn't natively render `.Rmd` files or interactive visualization within notebooks.
* View the raw code [here](analysis/project-final.Rmd)
* View the full interactive report [here](https://aliason.github.io/loan-prediction) 

*Revamped in May 2025 :) (original project 03-2023)*

