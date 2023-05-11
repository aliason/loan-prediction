# Load packages

library(corrplot)
library(corrr)
library(discrim)  # discriminant analysis
library(tidyverse)
library(tidymodels)  # for modeling functions 
library(ggplot2)   # for most of our visualizations
library(plyr); library(dplyr)   # for basic r functions
library(klaR) # for naive bayes
library(kableExtra)
library(knitr)   # to help with the knitting process
library(MASS)    # to assist with the markdown processes
library(naniar)  # for missing values
tidymodels_prefer()

# load data  
loan_ds <- read.csv("~/Desktop/Third year/PSTAT 131/project/project data/train.csv")
head(loan_ds)
str(loan_ds) 


# look at missing values
colSums(is.na(loan_ds))  
sapply(loan_ds,function(x) table(as.character(x) =="")["TRUE"])

# replace blanks w/ NA's
loan_ds <- read.csv(file="~/Desktop/Third year/PSTAT 131/project/project data/train.csv",
                    header=TRUE,na.strings = c("","NA")) 

# remove Loan_ID 
loan_ds <- loan_ds[,-1]; colnames(loan_ds)

# looking @ app income / coapp income, they make more sense as monthly incomes
# scale incomes up to annual 
# AND convert it into the same units as LoanAmount 
loan_ds$ApplicantIncome <- (loan_ds$ApplicantIncome*12)/1000
loan_ds$CoapplicantIncome <- (loan_ds$CoapplicantIncome*12)/1000



# convert categorical variables into factors. 
loan_ds$Gender <- factor(loan_ds$Gender, levels = c("Male","Female"))
loan_ds$Married <- factor(loan_ds$Married, levels = c("Yes","No"))
loan_ds$Education <- factor(loan_ds$Education, levels = c("Graduate","Not Graduate"))
loan_ds$Self_Employed <- factor(loan_ds$Self_Employed, levels = c("Yes","No"))
loan_ds$Dependents <- recode(loan_ds$Dependents,"3+"="3") %>%
  as.integer(loan_ds$Dependents)   # convert Dependents to numeric
loan_ds$Credit_History <- factor(loan_ds$Credit_History, 
                                 levels = c(1,0), labels = c("Yes","No"))  # convert CH into factor
loan_ds$Property_Area <- factor(loan_ds$Property_Area, levels = c("Rural","Semiurban","Urban"))
loan_ds$Loan_Status <- factor(loan_ds$Loan_Status, levels = c("Y","N"), labels = c("Yes","No")) 
str(loan_ds)


# visualize missing data
colSums(is.na(loan_ds))
gg_miss_var(loan_ds)   

# summary of missing values 
loan_ds %>%
  miss_var_summary()

sum(is.na(loan_ds))  # 149 

# first ignore and do EDA then KNN-imputate at a later step?

# remove obs w/ NA values under 5% 
# don't remove more than 10% of total data 




# EDA
# first do correlation matrix
# look at each variable 1 by 1
# create visualization plots, etc. 
# keep eye out for confounds



# loan status 
# first look @ distribution of response; let's make a barplot
loan_ds %>% 
  ggplot(aes(x = Loan_Status)) +
  geom_bar() + 
  theme_grey()

loan_ds %>%
  select(Loan_Status) %>%
  table() %>%
  prop.table()
# the data is definitely somewhat unbalanced; the proportion of applicants approved (0.68) is far greater
    # than the proportion of applicants rejected (0.32). 
# this may reflect some selection bias in the collection of our data; after all, qualified applicants
    # likely have a higher desire to apply for a loan. 

# for now, we won't adjust this. 
# but may need to consider upsampling / downsampling at a later step. 



# correlation plot 
# ...of numerical variables 

# do a correlation matrix first to see which variables to analyze together
  # which variables are correlated?
  # which relationships are potential confounds? 

loan_ds %>%
  select(where(is.numeric)) %>%
  na.omit() %>%   # remember to omit na.. or else you'll get ? marks in the grids
  cor() %>%
  corrplot()

# numerical corrplot
loan_ds %>%
  select(where(is.numeric)) %>%
  na.omit() %>%  
  cor() %>%
  corrplot(method="number")
# not too much correlation among predictors, most +/-0.20 
# there's a moderate correlation b/w loan amount and applicant income (0.57); 
  # may want to explore this 
# may reveal potential confounds; 


# let's analyze numerical variables first


# LOAN AMOUNT
# distribution
loan_ds %>%
  na.omit(LoanAmount) %>%
  ggplot(aes(x=LoanAmount)) + 
  geom_histogram(bins=40) +
  theme_grey()
# loan amount is skewed right, with most values b/w 0 and 400k
# this means extremely large outliers pull the mean upwards; mean > median  
# may want to come back to this in diagnostics.. 

loan_ds %>%
  ggplot(aes(y=LoanAmount)) + 
  geom_boxplot(na.rm=T) +
  theme_grey()


# loan amount vs. loan status 
loan_ds %>%
  na.omit(LoanAmount) %>%
  ggplot(aes(Loan_Status, LoanAmount)) + 
  geom_boxplot(na.rm=T) +
  geom_jitter(alpha = 0.1) +
  theme_grey()

# here we can see the actual summary stats
loan_ds %>%
  group_by(Loan_Status) %>%
  na.omit(LoanAmount) %>%
  dplyr :: summarise(min=min(LoanAmount), mean=mean(LoanAmount),n=n(), median=median(LoanAmount),
                     max=max(LoanAmount), IQR=IQR(LoanAmount), sd=sd(LoanAmount))
# width of box (IQR) is wider for No than Yes (even though Yes has a larger range); 
# No = lower range but more spread;
# mean is slightly higher for No, even though n is higher for Yes
# can't make any conclusions yet; 


# loan amount vs. applicant income
# recall that loan amount is positively correlated w income 
loan_ds %>%
  na.omit(LoanAmount) %>% 
  ggplot(aes(x=LoanAmount, y=ApplicantIncome)) +
  geom_point() 
# relationship non-linear
# seems like most applicants with apply for loans in the 0-400k range (we already know)
# no clear pattern - individuals who apply for a higher loan do tend to have slightly higher 
    # income, but nothing drastic

# let's see their approval rates
loan_ds %>%
  na.omit(LoanAmount) %>% 
  ggplot(aes(x=LoanAmount, y=ApplicantIncome, fill=Loan_Status,color=Loan_Status)) +
  geom_point() +
  theme_grey()
# of the individuals who apply for a higher loan, those w/a higher income are more likely to qualify
  # (somewhat)
# there are a few outliers 

# we should take a closer look at applicant income




# APPLICANT INCOME 
# distribution
loan_ds %>%
  filter(ApplicantIncome < 500) %>%  
    # omit high outliers for ease of visualization
  ggplot(aes(x=ApplicantIncome)) + 
  geom_histogram(fill="bisque",color="white",alpha=0.7, bins=20) + 
  geom_density() +
  geom_rug() + 
  labs(x = "applicant income") +
  theme_minimal()
# applicant income is right skewed, with most values b/w 0 and 300k
# a few extreme outliers > 500k

# let's inspect those outliers
loan_ds %>%
  filter(ApplicantIncome > 500)
# 2 out of 3 are fathers with dependents; 3 out of 3 are graduates
  # the only one not approved for a loan is 1. in a rural area, 2. has bad credit history. 
  # dependents don’t seem to matter when it comes to eligibility, neither does loan amount or term.
# keep that in mind 


# applicant income vs.loan_status
loan_ds %>%
  filter(ApplicantIncome < 500) %>%  
  ggplot(aes(x=ApplicantIncome,y=Loan_Status))+
  geom_boxplot() +
  theme_grey()
# nothing too significant; similar income level b/w applicants w/ Yes/No status


# proportions
loan_ds %>%
  filter(ApplicantIncome < 500) %>%  
  dplyr::mutate(bin = cut(ApplicantIncome, breaks=c(0, 100, 200, 300,400,500))) %>%
  group_by(bin, Loan_Status) %>% 
  dplyr:: summarise(n=n()) %>%
  dplyr::mutate(freq = prop.table(n))  
# About the same;
# Applicants w/ incomes w/in 0-100k have approval rate of 69% 
# Applicants w/ incomes w/in 100k-200k have approval rate of 66% 
# Applicants w/ incomes w/in 300k-400k have approval rate of 69% 
# Applicants w/ incomes w/in 400k-500k have approval rate of 75% 

# Applicants w/ higher income do tend to have a higher approval rate than those w/ lower incomes;
# Since there are so few data points in the (400,500] range; this may just be random variation.



# COAPPLICANT INCOME  
# distribution
loan_ds %>%
  ggplot(aes(x=CoapplicantIncome)) + 
  geom_histogram(fill="bisque",color="white",alpha=0.7, bins=20) + 
  geom_density() +
  geom_rug() + 
  labs(x = "coapplicant income") +
  theme_minimal()
# coapp income is also right skewed, w/ most values >100k 

loan_ds %>%
  dplyr :: count(CoapplicantIncome ==0)
# observe that a good amount of coapplicant incomes are == 0 (no coapplicant)
# let's explore this further

# how does the precense of a coapplicant affect an applicant's chances of getting approved? 
# FALSE means that there was a coapplicant, TRUE means that there wasn't. 
loan_ds %>%
  dplyr:: mutate(no_coapp = if_else(CoapplicantIncome == 0,TRUE,FALSE)) %>%
  group_by(no_coapp, Loan_Status) %>% 
  dplyr:: summarise(n=n()) %>%
  dplyr::mutate(freq = prop.table(n))  
# on average, ~72% of applicants w/ a coapplicant were approved for a loan
# while only ~65% of applicants w/o a coapplicant were approved.
# this is a pretty insightful finding! 

# let's check how coapp incomes compare to those of the applicants! 
loan_ds %>%
  filter(ApplicantIncome<500) %>%
  ggplot(aes(x=CoapplicantIncome, y=ApplicantIncome)) + 
  geom_point() +
  theme_minimal()
# nothing too useful



# LOAN AMOUNT TERM
loan_ds %>%
  na.omit(Loan_Amount_Term) %>%
  ggplot(aes(x=Loan_Amount_Term)) + 
  geom_bar() +
  theme_grey()
# mfv 360 

# 85% of the data have a loan term of 360 months! 
prop.table(table(loan_ds$Loan_Amount_Term))

# term vs. status
loan_ds %>%
  na.omit(Loan_Amount_Term) %>%  
  ggplot(aes(x=Loan_Amount_Term, fill=Loan_Status)) + 
  geom_bar(position="fill")
# applicants requesting short-term loans do seem to be more likely to get approved, on average;
  # though there is very little data to determine whether this is true.. 


# loan amount term vs. loan amount
loan_ds %>%
  na.omit(Loan_Amount_Term) %>%
  ggplot(aes(y=Loan_Amount_Term, x=LoanAmount, group = Loan_Amount_Term)) + 
  geom_boxplot() +
  theme_grey()
# variations in the average loan amount requested are small and unlikely to be signif
# greater range for 360 just b/c we have more data points for that category



# DEPENDENTS 
# distribution
loan_ds %>%
  na.omit(Dependents) %>%  # should be able to impute this later
  ggplot(aes(x=Dependents)) +
  geom_bar()
# most applicants have no dependents

# dependents vs. loan status
loan_ds %>%
  na.omit(Dependents) %>%  
  ggplot(aes(x=Dependents, fill=Loan_Status)) + 
  geom_bar(position="fill")
# relatively similar likelihood of approval for each # of dependents


# do applicants w/ a higher # of dependents request a larger loan?
loan_ds %>%
  na.omit(Dependents,LoanAmount) %>%  
  ggplot(aes(x=LoanAmount, y=Dependents, group=Dependents, fill=Dependents)) + 
  geom_boxplot()
# yes! 
# individuals with dependents, on average, request a larger loan amount


# how do the incomes of applicants w/ dependents compare to those who don't? 
loan_ds %>%
  filter(ApplicantIncome < 500) %>%  # for ease of visualization
  na.omit(Dependents,ApplicantIncome) %>% 
  ggplot(aes(x=ApplicantIncome, y=Dependents, group=Dependents, fill=Dependents)) + 
  geom_boxplot()
# surprisingly, no! 
# applicants w/ no dependents actually have lower incomes on average than those who do! 
# incomes tend drop a bit at 1 dependent, then rise again from 2-3. this is very odd! 
# maybe shows individuals w/ >=1 dependents are those who can afford to have one?




# GENDER
prop.table(table(loan_ds$Gender))
# much more males than females.. unrepresentative? 

# is there bias in the selection process? 
# percent stacked bar chart
loan_ds %>%
  na.omit(Gender) %>%  # should be able to impute this later
  ggplot(aes(x=Gender, fill=Loan_Status)) + 
  geom_bar(position="fill")
# no apparent bias in approval rates b/w males/females; about the same 

# 2-way contingency table 
loan_ds %>%
  na.omit(Gender) %>%
  group_by(Gender, Loan_Status) %>% 
  dplyr:: summarise(n=n()) %>%
  dplyr::mutate(freq = prop.table(n))  
# slight bias; females 8% less likely to be approved than males


# is there an income disparity? 
loan_ds %>%
  na.omit(Gender) %>% 
  dplyr::filter(ApplicantIncome<500) %>%  
    # remove outliers for ease of visualization
  ggplot(aes(x=ApplicantIncome, y=reorder(Gender,ApplicantIncome))) + 
  geom_boxplot() +
  theme_bw() +
  labs(x="Gender", y="Applicant Income")
# about the same; 
# although variation in male incomes is much higher than that of female incomes

# are females or males more likely to claim dependents?
loan_ds %>%
  na.omit(Gender) %>%  
  ggplot(aes(x=Gender, fill=factor(Dependents))) + 
  geom_bar(position="fill")
#  males are more likely to claim dependents!!




# MARRIED
# distribution
prop.table(table(loan_ds$Married))
# married individuals are more likely to apply for loans?? 

# are married individuals more likely to be approved?
loan_ds %>%
  na.omit(Married) %>%
  ggplot(aes(x=Married,fill=Loan_Status)) +
  geom_bar(position="fill")

# 2-way contingency table 
loan_ds %>%
  na.omit(Married) %>%
  group_by(Married, Loan_Status) %>% 
  dplyr:: summarise(n=n()) %>%
  dplyr::mutate(freq = prop.table(n))  
# here we can see the absolute and realtive frequencies of each pairing
# it's clear that married individuals are more likely to be approved than non-married individuals
  # ~10% more likely
# given the size of our dataset, 10% is pretty large! 


# how do the incomes of married/unmarried applicants compare?
loan_ds %>%
  na.omit(Married) %>%
  dplyr::filter(ApplicantIncome<500) %>%  
  # remove outliers for ease of visualization
  ggplot(aes(x=ApplicantIncome, y=Married)) + 
  geom_boxplot() +
  theme_bw() +
  labs(y="Married", x="Applicant Income")
# about the same! 


# married vs. dependents vs. loan status
loan_ds %>%
  na.omit(Married) %>%  
  ggplot(aes(x=Married, fill=factor(Dependents))) + 
  geom_bar(position="dodge") +
  facet_wrap(~Loan_Status)  
# married individuals who get approved tend to also have dependents; 
# unmarried individuals who are approved DONT; 



# EDUCATION
loan_ds %>%
  na.omit(Education) %>%
  ggplot(aes(x=Education,fill=Loan_Status)) +
  geom_bar(position="fill")
# graduates are slightly more likely to get approved 

prop.table(table(loan_ds$Education))
# our data is comprised of ~80% graduates!
# makes sense b/c educational loans, etc. 


# 2-way contingency table 
loan_ds %>%
  na.omit(Education) %>%
  group_by(Education, Loan_Status) %>% 
  dplyr:: summarise(n=n()) %>%
  dplyr::mutate(freq = prop.table(n))  
# graduates are about 8% more likely 

# education vs income
loan_ds %>%
  na.omit(Education) %>%
  dplyr::filter(ApplicantIncome<500) %>%  
  # remove outliers for ease of visualization
  ggplot(aes(x=ApplicantIncome, y=Education)) + 
  geom_boxplot() +
  theme_bw() +
  labs(y="Education", x="Applicant Income")
# graduate income tend to be higher!



# SELF EMPLOYED 
loan_ds %>%
  na.omit(Self_Employed) %>%
  ggplot(aes(x=Self_Employed,fill=Loan_Status)) +
  geom_bar(position="fill")

# 2-way contingency table 
loan_ds %>%
  na.omit(Self_Employed) %>%
  group_by(Self_Employed, Loan_Status) %>% 
  dplyr:: summarise(n=n()) %>%
  dplyr::mutate(freq = prop.table(n))  
# slight difference; not self-empoyed 4% more likely to be approved


# CREDIT HISTORY 
prop.table(table(loan_ds$Credit_History))
# most applicants have good credit history! 

loan_ds %>%
  na.omit(Credit_History) %>%
  ggplot(aes(x=Credit_History,fill=Loan_Status)) +
  geom_bar(position="fill")

# 2-way contingency table 
loan_ds %>%
  na.omit(Credit_History) %>%
  group_by(Credit_History, Loan_Status) %>% 
  dplyr:: summarise(n=n()) %>%
  dplyr::mutate(freq = prop.table(n))  
# *** VERY important predictor!!
# about 70% more likely to be approved if yes! 
# only 10% of applicants w/ bad credit history get approved


# education vs credit history
# maybe students (grads) tend to have bad credit history (loans) ? 
loan_ds %>%
  na.omit(Credit_History) %>%
  ggplot(aes(x=Education,fill=Credit_History)) +
  geom_bar(position="fill")
# no significant difference 




# PROPERTY AREA 
prop.table(table(loan_ds$Property_Area))
# good mix of applicants from all 3 areas

loan_ds %>%
  na.omit(Property_Area) %>%
  ggplot(aes(x=Property_Area,fill=Loan_Status)) +
  geom_bar(position="fill")
# semiurban w/ highest approval rate
# then urban, then rural

# 2-way contingency table 
loan_ds %>%
  na.omit(Property_Area) %>%
  group_by(Property_Area, Loan_Status) %>% 
  dplyr:: summarise(n=n()) %>%
  dplyr::mutate(freq = prop.table(n))  
# semiurban is 13% ore likely to be approved than urban
# and 17% more likely to be approved than rural!! 

# why is this the case?
# is property area related to any other predictors?
loan_ds %>%
  na.omit(Property_Area) %>%
  ggplot(aes(x=Property_Area,fill=Married)) +
  geom_bar(position="dodge")
# equal proportions of married individuals relative to unmarried individuals live in each area
# BUT more married individuals do tend to prefer a semiurban area > rural or urban



# strongest predictors: married, coapplicant, credit history, property area
  # married 10% more likely to be approved > unmarried!
  # semiurban is 13% ore likely to be approved than urban
      #  and 17% more likely to be approved than rural!! 
  # credit; about 70% more likely to be approved if yes! 
  # applicants w/ coapplicants are 7% more likely to be approved!
  



save(loan_ds, file = "~/Desktop/Third year/PSTAT 131/project/rda_files/eda.rda")




