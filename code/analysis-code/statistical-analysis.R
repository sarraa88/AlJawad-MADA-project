###############################################
# Analysis Script
#
# Purpose:
# This script loads the processed lung cancer data
# and performs statistical analyses.
#
# Input:
# data/processed-data/lung_clean.csv
#
# Output:
# results/tables/
# results/figures/
###############################################

# Load needed packages
library(ggplot2)
library(broom)
library(here)

# Path to processed data
data_location <- here::here("data", "processed-data", "lung_clean.csv")

# Load data
mydata <- read.csv(data_location)

# Convert variables to factors for logistic regression
mydata$lung_cancer_risk <- factor(mydata$lung_cancer_risk, levels = c("No", "Yes"))
mydata$smoker <- factor(mydata$smoker)
mydata$copd <- factor(mydata$copd)

######################################
# Data fitting / statistical analysis
######################################

############################
# First model:
# Logistic regression: lung cancer risk ~ age
############################

model_age <- glm(lung_cancer_risk ~ age, data = mydata, family = binomial)

# Tidy model output
table_age <- broom::tidy(model_age)
print(table_age)

# Save coefficient table
table_file1 <- here("results", "tables", "age_model_results.csv")
write.csv(table_age, file = table_file1, row.names = FALSE)

# Odds ratios for age model
or_age <- exp(coef(model_age))
print(or_age)

# Confidence intervals for odds ratios
or_ci_age <- exp(confint(model_age))
print(or_ci_age)

# Save odds ratios
or_age_df <- data.frame(
  term = names(or_age),
  odds_ratio = as.numeric(or_age)
)
write.csv(
  or_age_df,
  file = here("results", "tables", "age_model_odds_ratios.csv"),
  row.names = FALSE
)

# Save confidence intervals
or_ci_age_df <- data.frame(
  term = rownames(or_ci_age),
  conf.low = or_ci_age[, 1],
  conf.high = or_ci_age[, 2]
)
write.csv(
  or_ci_age_df,
  file = here("results", "tables", "age_model_or_confint.csv"),
  row.names = FALSE
)

# Create prediction dataset for age
age_seq <- seq(min(mydata$age), max(mydata$age), length.out = 100)

pred_df <- data.frame(
  age = age_seq,
  prob = predict(
    model_age,
    newdata = data.frame(age = age_seq),
    type = "response"
  )
)

# Plot predicted probability by age
p_age <- ggplot(pred_df, aes(x = age, y = prob)) +
  geom_line(color = "blue", linewidth = 1) +
  labs(
    title = "Predicted lung cancer risk by age",
    x = "Age",
    y = "Predicted probability of lung cancer"
  ) +
  theme_minimal()

print(p_age)

# Save figure
figure_file1 <- here("results", "figures", "predicted_lung_cancer_risk_by_age.png")
ggsave(filename = figure_file1, plot = p_age, width = 7, height = 5)

############################
# Second model:
# Logistic regression: lung cancer risk ~ age + smoker
############################

model_age_smoke <- glm(lung_cancer_risk ~ age + smoker, data = mydata, family = binomial)

# Tidy model output
table_age_smoke <- broom::tidy(model_age_smoke)
print(table_age_smoke)

# Save coefficient table
table_file2 <- here("results", "tables", "age_smoking_model_results.csv")
write.csv(table_age_smoke, file = table_file2, row.names = FALSE)

############################
# Third model:
# Logistic regression: lung cancer risk ~ age + pack_years
############################

model_age_pack <- glm(lung_cancer_risk ~ age + pack_years, data = mydata, family = binomial)

# Tidy model output
table_age_pack <- broom::tidy(model_age_pack)
print(table_age_pack)

# Save coefficient table
table_file3 <- here("results", "tables", "age_packyears_model_results.csv")
write.csv(table_age_pack, file = table_file3, row.names = FALSE)


# Pack-years vs lung cancer risk plot


pack_seq <- seq(min(mydata$pack_years), max(mydata$pack_years), length.out = 100)

pred_pack <- data.frame(
  pack_years = pack_seq,
  age = median(mydata$age, na.rm = TRUE)
)

pred_pack$prob <- predict(
  model_age_pack,
  newdata = pred_pack,
  type = "response"
)

p_pack <- ggplot(pred_pack, aes(x = pack_years, y = prob)) +
  geom_line(color = "blue", linewidth = 1) +
  labs(
    title = "Predicted lung cancer risk by pack-years (at median age)",
    x = "Pack-years",
    y = "Predicted probability of lung cancer"
  ) +
  theme_minimal()

print(p_pack)

# Save figure
figure_file2 <- here("results", "figures", "predicted_lung_cancer_risk_by_packyears (at median age).png")

ggsave(
  filename = figure_file2,
  plot = p_pack,
  width = 7,
  height = 5
)


############################
# Fourth model:
# Logistic regression: lung cancer risk ~ age + pack_years + copd
############################
# This model evaluates whether COPD provides additional predictive value
# beyond age and cumulative smoking exposure (pack-years)

# Fit model
model_age_pack_copd <- glm(
  lung_cancer_risk ~ age + pack_years + copd,
  data = mydata,
  family = binomial
)

# Tidy model output
table_age_pack_copd <- broom::tidy(model_age_pack_copd)
print(table_age_pack_copd)

# Save coefficient table
write.csv(
  table_age_pack_copd,
  file = here("results", "tables", "age_packyears_copd_model_results.csv"),
  row.names = FALSE
)

# Odds ratios
or_copd <- exp(coef(model_age_pack_copd))
print(or_copd)

# Confidence intervals
or_ci_copd <- exp(confint(model_age_pack_copd))
print(or_ci_copd)

# Save odds ratios
or_copd_df <- data.frame(
  term = names(or_copd),
  odds_ratio = as.numeric(or_copd)
)

write.csv(
  or_copd_df,
  file = here("results", "tables", "age_packyears_copd_odds_ratios.csv"),
  row.names = FALSE
)

# Save confidence intervals
or_ci_copd_df <- data.frame(
  term = rownames(or_ci_copd),
  conf.low = or_ci_copd[, 1],
  conf.high = or_ci_copd[, 2]
)

write.csv(
  or_ci_copd_df,
  file = here("results", "tables", "age_packyears_copd_confint.csv"),
  row.names = FALSE
)

############################
# Combine regression results into one table
############################



reg_table <- data.frame(
  Variable = c("Age", "Pack-years", "COPD"),
  Odds_Ratio = or_copd[c("age", "pack_years", "copdYes")],
  CI_lower = or_ci_copd[c("age", "pack_years", "copdYes"), 1],
  CI_upper = or_ci_copd[c("age", "pack_years", "copdYes"), 2],
  p_value = table_age_pack_copd$p.value[2:4]
)

# Save as RDS
saveRDS(
  reg_table,
  here("results", "tables", "regression_table.rds")
)

print("Statistical analysis complete. Tables and figures saved.")