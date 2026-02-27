# eda-code

This folder contains R scripts used to perform exploratory data analysis (EDA) on the cleaned lung cancer dataset.

## Script description

02_eda_plots_tables.R

- Input: `data/processed-data/lung_clean.rds`
- Actions:
  - Computes summary statistics stratified by lung cancer risk
  - Generates tables and boxplots for age and pack-years
  - Computes smoking proportions
- Output:
  - Tables saved to `results/tables/`
  - Figures saved to `results/figures/`

This script should be run after the data processing step in `processing-code/`.