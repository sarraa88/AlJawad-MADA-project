
# Lung Cancer Risk Analysis  
Saraa Al-Jawad  
Modern Applied Data Analysis (MADA)

This repository contains my cumulative course project in Dr. Andreas Handel's Modern Applied Data Analysis course.

## Project Overview

This project investigates factors associated with lung cancer risk using a dataset of 5,000 individuals.

The dataset contains demographic, clinical, and smoking-related variables.  

The project includes:

- Data cleaning and preprocessing
- Exploratory data analysis (EDA)
- Descriptive and statistical modeling
- Fully reproducible workflow implementation

The goal is to examine potential associations between lung cancer and relevant predictors in a fully reproducible workflow.



# Pre-requisites

This is using R, Quarto, GitHub and a reference manager that can handle BibTeX. Our recommendation for the reference manager is Zotero, with the Better BibTeX plugin/extension. It is also assumed that you have a word processor installed (e.g. MS Word or [LibreOffice](https://www.libreoffice.org/)). You need that software stack to make use of this template. To produce PDF output, you need a TeX distribution installed. You can use TinyTeX, following [these instructions.](https://quarto.org/docs/output-formats/pdf-basics.html)


## Repository Structure

### `data/`
Contains the raw and processed datasets.

- `raw-data/`
  - Where you can find the original dataset, not modified.
- `processed-data/`
  - Cleaned dataset created by the processing scripts.

Each dataset can be regenerated using scripts in the `code/` folder.

---

### `code/`

Contains all code used in this project.

- `processing-code/`
  - To load and clean the raw dataset.
- `eda-code/`
  - To produces summary tables and exploratory figures.
- `analysis-code/`
  - Scripts for statistical and predictive modeling

Each subfolder also includes a `README.md` describing purpose and workflow.

---

### `results/`

Contains code-generated output:

- Figures (`.png`, `.pdf`)
- Tables (`.rds`, `.csv`)
- Intermediate saved objects

All files in this folder are produced by code.

---

### `products/`

Contains finalized outputs of the project:

- `manuscript/`
  - `Manuscript.qmd` and related files in Word/PDF output.


---

### `assets/`

Contains supporting files:

- `dataanalysis-references.bib` — BibTeX references
- `.csl` citation style files


### Reproducibility

Detailed instructions for running the analysis workflow are provided in:

`code/README.md`