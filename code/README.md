# code

This folder contains all scripts used for data processing and exploratory analysis of the lung cancer dataset.

## Folder structure and workflow

### 1. processing-code/

Scripts in this folder perform data loading and cleaning.

- **01_load_clean.R**
  - Input: `data/raw-data/lung_cancer.csv`
  - Actions: Loads raw data, converts variable types, performs basic cleaning.
  - Output: Cleaned dataset saved to `data/processed-data/lung_clean.rds`

---

### 2. eda-code/

Scripts in this folder perform exploratory data analysis.

- **02_eda_plots_tables.R**
  - Input: `data/processed-data/lung_clean.rds`
  - Actions: Computes summary statistics, generates tables and figures.
  - Output:
      - Tables saved to `results/tables/`
      - Figures saved to `results/figures/`

---

## Order of execution

To fully reproduce the analysis:

1. Run scripts in `processing-code/` first.
2. Then run scripts in `eda-code/`.
3. Finally, render `Manuscript.qmd` in the `products/manuscript/` folder.

All scripts are documented with comments describing their purpose, inputs, and outputs.

