load("~/Desktop/School/PSTAT/PSTAT 131/proj-final/rda_files/loan-setup.rda")

set.seed(3450)

# pruned decision tree

# Set up the model by specifying its type, engine, and mode.  
dt_mod <- decision_tree(cost_complexity = tune()) %>%
  set_mode("classification") %>%
  set_engine("rpart")


# Set up the workflow; add the model and defined recipe. 
dt_wf <- workflow() %>%
  add_recipe(loan_recipe) %>%
  add_model(dt_mod) 


# Use `grid_regular` to set up tuning grids of values for the parameters we're tuning and specify levels for each.
dt_grid <- grid_regular(cost_complexity(range = c(-3, -1)), levels = 10)

# note that cost_completxity() uses the log10_trans() functions by default; 
# so -3 and -1 are in the log10 scale 



# Fit the models to our folded data via `tune_grid()`
dt_tune_res <- tune_grid(
  dt_wf, 
  resamples = loan_folds, 
  grid = dt_grid, 
  metrics = metric_set(yardstick::roc_auc)
)


# Select the best parameter value and finalize the workflow. 
best_dt <- select_best(dt_tune_res); best_dt
dt_final_wf <- finalize_workflow(dt_wf, best_dt)



# Fit the model to the training data. 
dt_final_fit <- fit(dt_final_wf, data = loan_train)


# Save results to RDA file. 
save(dt_tune_res, dt_final_wf, dt_final_fit, 
     file= "~/Desktop/School/PSTAT/PSTAT 131/proj-final/rda_files/decision-tree.rda")

