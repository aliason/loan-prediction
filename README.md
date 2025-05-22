# Loan Prediction Machine Learning Project

## Project Description
This repository contains the code for the final course project of PSTAT 131 (Statistical Machine Learning) at UCSB. Students apply machine learning algorithms to solve a real-world problem of their choosing and use Markdown to compile a report of key findings.

My project tackles a binary classification problem: predict loan eligibility based on applicant demographics. I take a structured and analytical approach, incrementally traversing the data science life cycle and leveraging multiple techniques to identify the best model for the problem. 

**Note**: GitHub doesn't natively render `.Rmd` files or interactive visualization within notebooks.
* View the raw code [here](proj-final/project-final.Rmd)
* View the full interactive report [here](https://aliason.github.io/loan-prediction) 


## Data Sources
The files consist of a training (`train.csv`) and test set (`test.csv`). The test set is identical to the training except for the loan status to be predicted. The training set consists of 614 observations on 13 variables; the test set consists of 367 observations on 12. 

Note that `test.csv` will not be used in this project, as it only applies supervised learning models, which require the target variable to be known. A 70/30 split will be performed on `train.csv` for model evaluation.

## Project Roadmap  
The project will follow a structured approach, starting with data processing and cleaning, followed by exploration, analysis, and modeling. 

First, I load the dataset into R, assess its structure, and perform initial data tidying to address errors and inconsistencies. Next, I conduct exploratory data analysis (EDA), extracting insights to guide further preprocessing. The dataset undergoes final tidying before modeling.

To begin: I perform a 70/30 (train/test) split, build a preprocessing recipe, and establish validation sets (10) for model selection and tuning. Models are trained in separate RDA files before being loaded back in for evaluation. The top 3 models are selected for testing, and multiple visualizations are created for clarity.

The project concludes with a detailed summary of key takeaways and findings. 

## Methods used 
* Data processing
    * Missing values (imputation via MICE)
    * Duplicates
    * Feature transformation (scaling, binning, categorical encoding)
* EDA 
    * Distributional analysis (histograms, barplots, scatterplots)
    * Feature analysis 
    * Correlation analysis (heatmaps, corrplots)
    * Inferential statistics 
* Data modeling
    * Models: logistic regression, LDA, KNN, QDA, elastic net (Ridge), pruned decision trees
    * Resampling: grid search, k-fold CV 
    * Evaluation: ROC-AUC, confusion matrix, lollipop plots 

Tools
* R + libraries (ggplot2, tidyverse, corrplot, MASS, and more). 
* R Markdown
* Excel (codebook)
