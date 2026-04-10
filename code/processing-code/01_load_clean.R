# ===============================
# 01_load_clean.R
# Load and clean lung cancer data
# ===============================
# Purpose:
# This script loads the raw lung cancer dataset,
# performs basic cleaning and saves a processed dataset for analysis.
#
# Input:
# data/raw-data/lung_cancer.csv
#
# Output:
# data/processed-data/lung_clean.csv
###############################################

library(tidyverse)
library(here)

# -------------------------------
# Load raw data
# -------------------------------

# Load required packages
lung <- readr::read_csv(
  here("data", "raw-data", "lung_cancer.csv")
)

# -------------------------------
# Clean & recode variables
# -------------------------------
# - Convert numeric indicators (0/1) to factors
# - Create a categorical variable for pack-years
#   based on the median value

lung_clean <- lung %>%
  mutate(
    lung_cancer_risk = factor(lung_cancer_risk, levels = c(0,1), labels = c("No","Yes")),
    smoker = factor(smoker, levels = c(0,1), labels = c("Non-smoker","Smoker")),
    copd = factor(copd, levels = c(0,1), labels = c("No","Yes"))
  ) %>%
  mutate(
    # Compute median pack-years (used for grouping)
    median_pack = median(pack_years, na.rm = TRUE),

    # Create binary grouping variable for smoking exposure
    pack_group = if_else(pack_years <= median_pack,
                         "Low pack-years",
                         "High pack-years"),
    pack_group = factor(pack_group)
  ) %>%
  select(-median_pack)

# -------------------------------
# Save cleaned dataset
# -------------------------------

# Create output directory if it does not exist
dir.create(here("data","processed-data"),
           recursive = TRUE,
           showWarnings = FALSE)

# Save cleaned dataset for downstream analysis
readr::write_csv(
  lung_clean,
  here("data","processed-data","lung_clean.csv")
)

print("Cleaning complete. Clean file saved.")