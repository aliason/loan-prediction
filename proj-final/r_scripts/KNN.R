load("~/Desktop/Third year/PSTAT 131/project/rda_files/loan-setup.rda")

set.seed(3450)

# Set up the model by specifying its type, engine, and mode.  
knn_mod <- nearest_neighbor(neighbors=tune()) %>%
  set_engine("kknn") %>% 
  set_mode("classification") 


# Set up the workflow; add the model and defined recipe. 
knn_wkflow <- workflow() %>% 
  add_model(knn_mod) %>% 
  add_recipe(loan_recipe)


# Use `grid_regular` to set up tuning grids of values for the parameters we're tuning and specify levels for each.
knn_grid <- grid_regular(neighbors(range = c(1, 10)), levels = 10)
# since we have 1 parameter and 10 possible values for k, 
    # we have a total of 10 folds x 10 values = 100 different models.


# Fit the models to our folded data via `tune_grid()`
knn_tune_res <- tune_grid(
  object = knn_wkflow, 
  resamples = loan_folds, 
  grid = knn_grid,
  metrics = metric_set(yardstick::roc_auc)
)


# Select the best parameter value and finalize the workflow. 
collect_metrics(knn_tune_res)
best_k <- select_best(knn_tune_res, metric = "roc_auc")
best_k

knn_wkflow_final <- finalize_workflow(knn_wkflow, best_k)


# Fit the model to the training data. 
knn_final_fit <- fit(knn_wkflow_final, data = loan_train)


# Save results to RDA file. 
save(knn_tune_res, knn_wkflow_final, knn_final_fit, file= "~/Desktop/Third year/PSTAT 131/project/rda_files/knn.rda")

