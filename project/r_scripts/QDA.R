load("~/Desktop/Third year/PSTAT 131/project/rda_files/loan-setup.rda")

set.seed(3450)


# Set up the model by specifying its type, engine, and mode.  
qda_mod <- discrim_quad() %>% 
  set_mode("classification") %>% 
  set_engine("MASS")

# Set up the workflow; add the model and defined recipe.
qda_wkflow <- workflow() %>% 
  add_model(qda_mod) %>% 
  add_recipe(loan_recipe)


# Fit the model to the training data. 
qda_fit <- fit(qda_wkflow, loan_train)
predict(qda_fit, new_data = loan_train, type="prob")


# fit model to folded data 
qda_kfold_fit <- qda_wkflow %>% 
  fit_resamples(resamples = loan_folds, control = control_grid(save_pred = TRUE))
collect_metrics(qda_kfold_fit)


# Save results to RDA file. 
save(qda_wkflow,qda_fit ,qda_kfold_fit, 
     file= "~/Desktop/Third year/PSTAT 131/project/rda_files/qda.rda")

