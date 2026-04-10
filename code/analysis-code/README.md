# analysis-code

This folder contains R scripts and Quarto file used to perform statistical analysis on the cleaned lung cancer dataset.

## Script description

- Input: `data/processed-data/lung_clean.csv`
- Actions:
  - Perfoms logistic regression models to examine associations between predictors and lung cancer risk. 
  - Implements train/test splitting for model development and evaluation. 
  - Evaluates model performance using accuracy, sensitivity, specificity, and AUC  
  - Generates summary tables and figures
- Output:
  - Tables saved to `results/tables/`
  - Figures saved to `results/figures/`

These should be run after the exploratory analysis step in `eda-code/`.
