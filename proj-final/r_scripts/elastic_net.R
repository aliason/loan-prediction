load("~/Desktop/Third year/PSTAT 131/project/rda_files/loan-setup.rda")

set.seed(3450)

# Set up the model by specifying its type, engine, and mode.  
en_mod <- logistic_reg(mixture = tune(), penalty = tune()) %>%
  set_engine("glmnet") %>% 
  set_mode("classification") 


# Set up the workflow; add the model and defined recipe. 
en_wkflow <- workflow() %>% 
  add_model(en_mod) %>% 
  add_recipe(loan_recipe)


# Use `grid_regular` to set up tuning grids of values for the parameters we're tuning and specify levels for each.
en_grid <- grid_regular(penalty(range = c(0, 1), trans = identity_trans()),
                        mixture(range = c(0, 1)), levels = 10)

# penalty = lambda (amount of regularization)
# mixture = proportion of lasso 

# since penalty is is log-scaled by default;
  # use trans = identity_trans() to tell R that we want to use the exact values supplied. 
# 2 parameters to tune x 10 levels each = 10^2 = 100 possible combos; 100 x 10 folds = 1000 models 



# Fit the models to our folded data via `tune_grid()`
en_tune_res <- tune_grid(
  object = en_wkflow, 
  resamples = loan_folds, 
  grid = en_grid, 
  metrics = metric_set(yardstick::roc_auc)
)
 # 10ˆ2 = 100 models per fold x 2 metrics = 200 

autoplot(en_tune_res)  # visualize results 
# the scale of the y-axis for both metrics is relatively small,
  # indicates that performance doesn’t vary drastically across models
# x-axis = penalty, lengend = mixture (diff colored lines)
# lower penalty = better in terms of roc_auc
# lower mixture too; models start doing worse as the amount of regularization increases. 


# Select the best parameter value and finalize the workflow. 
collect_metrics(en_tune_res)  
  # raw metrics for each mixture/penalty pairing average across all 10 folds

best_en <- select_best(en_tune_res, metric = "roc_auc")
best_en

en_wkflow_final <- finalize_workflow(en_wkflow, best_en)


# Fit the model to the training data. 
en_final_fit <- fit(en_wkflow_final, data = loan_train)


# Save results to RDA file. 
save(en_tune_res, en_wkflow_final, en_final_fit, 
     file= "~/Desktop/Third year/PSTAT 131/project/rda_files/en.rda")

