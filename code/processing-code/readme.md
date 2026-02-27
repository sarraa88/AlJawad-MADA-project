# processing-code

This folder contains scripts for data loading and cleaning of the lung cancer dataset.

## Script description

01_load_clean.R

- Input: `data/raw-data/lung_cancer.csv`
- Actions:
  - Loads raw data
  - Converts key variables to appropriate data types
  - Performs basic cleaning and formatting
- Output:
  - Cleaned dataset saved to `data/processed-data/lung_clean.rds`

This script must be run before any exploratory analysis scripts in the `eda-code/` folder.