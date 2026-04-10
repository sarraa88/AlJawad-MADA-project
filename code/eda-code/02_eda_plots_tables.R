# =====================================
# 02_eda_plots_tables.R
# Exploratory Data Analysis
# =====================================
# Purpose:
# This script performs exploratory data analysis (EDA)
# for the lung cancer dataset. It generates a summary
# table and several exploratory figures to compare
# age, smoking exposure, and smoking prevalence by
# lung cancer risk group.
#
# Input:
# data/processed-data/lung_clean.csv
#
# Output:
# results/tables/summarytable.rds
# results/figures/age_box.png
# results/figures/packyears_box.png
# results/figures/age_vs_packyears_scatter.png
# results/figures/smoking_proportion.png
###############################################
# Load required packages

library(tidyverse)
library(here)
library(scales)

# -------------------------------
# Load cleaned data
# -------------------------------
# Read the processed dataset created in the
# data cleaning step.

lung <- readr::read_csv(
  here("data","processed-data","lung_clean.csv")
)

# Create results folders if needed
dir.create(here("results","figures"), recursive = TRUE, showWarnings = FALSE)
dir.create(here("results","tables"), recursive = TRUE, showWarnings = FALSE)

# --------------------------------------------
# Summary table by lung cancer risk
# --------------------------------------------
# For each lung cancer risk group, calculate:
# - number of observations
# - median and IQR for age
# - median and IQR for pack-years
# - percentage of smokers
# - percentage of COPD cases

summary_tbl <- lung %>%
  group_by(lung_cancer_risk) %>%
  summarise(
    n = n(),
    median_age = median(age, na.rm = TRUE),
    IQR_age = IQR(age, na.rm = TRUE),
    median_pack_years = median(pack_years, na.rm = TRUE),
    IQR_pack_years = IQR(pack_years, na.rm = TRUE),
    percent_smokers = mean(smoker == "Smoker") * 100,
    percent_COPD = mean(copd == "Yes") * 100
  )

# Save summary table for use in manuscript
saveRDS(summary_tbl,
        here("results","tables","summarytable.rds"))

# -------------------------------
# Plot 1: Age boxplot
# -------------------------------
# Boxplot comparing age between lung cancer risk groups.
p_age_box <- ggplot(lung,
                    aes(x = lung_cancer_risk,
                        y = age,
                        fill = lung_cancer_risk)) +
  geom_boxplot(alpha = 0.7) +
  labs(x = "Lung cancer risk",
       y = "Age") +
  theme(legend.position = "none")
# Save age boxplot
ggsave(here("results","figures","age_box.png"),
       p_age_box,
       width = 6,
       height = 4,
       dpi = 300)

# -------------------------------
# Plot 2: Pack-years boxplot
# -------------------------------
# Boxplot comparing cumulative smoking exposure
# between lung cancer risk groups.
p_pack_box <- ggplot(lung,
                     aes(x = lung_cancer_risk,
                         y = pack_years,
                         fill = lung_cancer_risk)) +
  geom_boxplot(alpha = 0.7) +
  labs(x = "Lung cancer risk",
       y = "Pack-years") +
  theme(legend.position = "none")

# Save pack-years boxplot
ggsave(here("results","figures","packyears_box.png"),
       p_pack_box,
       width = 6,
       height = 4,
       dpi = 300)
# -------------------------------
# Plot 3: Age vs pack-years scatter (pack_years > 0 only)
# -------------------------------

p_age_pack_scatter <- lung %>%
  filter(pack_years > 0) %>%
  ggplot(aes(x = age, y = pack_years, color = lung_cancer_risk)) +
  geom_point(alpha = 0.35, size = 1) +
  labs(
    x = "Age",
    y = "Pack-years",
    color = "Cancer risk"
  ) +
  theme_classic(base_size = 12)

# Save scatter plot
ggsave(
  here("results","figures","age_vs_packyears_scatter.png"),
  p_age_pack_scatter,
  width = 6, height = 4, dpi = 300)
# -------------------------------
# Plot 4: Smoking prevalence by lung cancer risk
# -------------------------------
# Stacked proportional bar plot showing the
# percentage of smokers and non-smokers in each
# lung cancer risk group.

p_smoke_prop <- ggplot(lung,
                       aes(x = lung_cancer_risk,
                           fill = smoker)) +
  geom_bar(position = "fill", width = 0.6) +
  scale_y_continuous(labels = percent_format()) +
  scale_fill_manual(values = c("#bdbdbd", "#1f78b4")) +
  labs(x = "Lung cancer risk",
       y = "Percentage",
       fill = "Smoking status") +
  theme_classic(base_size = 12) +
  theme(legend.position = "top")

# Save smoking prevalence plot
ggsave(here("results","figures","smoking_proportion.png"),
       p_smoke_prop,
       width = 6,
       height = 4,
       dpi = 300)
print("EDA complete. Plots and table saved.")