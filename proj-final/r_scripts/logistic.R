load("~/Desktop/School/PSTAT/PSTAT 131/proj-final/rda_files/loan-setup.rda")
set.seed(3450)


# Set up the model by specifying its type, engine, and mode.  
log_mod <- logistic_reg() %>% 
  set_engine("glm") %>%
  set_mode("classification")

# Set up the workflow; add the model and defined recipe.
log_wkflow <- workflow() %>% 
  add_model(log_mod) %>% 
  add_recipe(loan_recipe)


# Fit the model to the training data. 
log_fit <- fit(log_wkflow, loan_train)
predict(log_fit, new_data = loan_train, type="prob")


# fit model to folded data 
log_kfold_fit <- log_wkflow %>% 
  fit_resamples(resamples = loan_folds)

collect_metrics(log_kfold_fit)


# Save results to RDA file. 
save(log_wkflow,log_fit,log_kfold_fit, file= "~/Desktop/School/PSTAT/PSTAT 131/proj-final/rda_files/logistic.rda")

