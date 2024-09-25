load("~/Desktop/School/PSTAT/PSTAT 131/proj-final/rda_files/loan-setup.rda")

set.seed(3450)


# Set up the model by specifying its type, engine, and mode.  
lda_mod <- discrim_linear() %>% 
  set_mode("classification") %>% 
  set_engine("MASS")

# Set up the workflow; add the model and defined recipe.
lda_wkflow <- workflow() %>% 
  add_model(lda_mod) %>% 
  add_recipe(loan_recipe)


# Fit the model to the training data. 
lda_fit <- fit(lda_wkflow, loan_train)
predict(lda_fit, new_data = loan_train, type="prob")


# fit model to folded data 
lda_kfold_fit <- lda_wkflow %>% 
  fit_resamples(resamples = loan_folds)

collect_metrics(lda_kfold_fit)


# Save results to RDA file. 
save(lda_wkflow,lda_fit,lda_kfold_fit, 
     file= "~/Desktop/School/PSTAT/PSTAT 131/proj-final/rda_files/lda.rda")

