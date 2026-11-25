# Physical Activity and Diabetes Prevalence in US Adults

A SAS analysis of CDC Behavioral Risk Factor Surveillance System (BRFSS) 2023 data.

## Research question

Is leisure-time physical activity associated with self-reported diabetes among US adults, after controlling for age, sex, BMI category, education, and income?

## Dataset

CDC Behavioral Risk Factor Surveillance System (BRFSS) 2023, public-use data
(433,323 records; 345 variables in the SAS transport file).

### Get the real data

1. Go to the CDC 2023 BRFSS data page:
   https://www.cdc.gov/brfss/annual_data/annual_2023.html
2. Download **"2023 BRFSS Data (SAS Transport Format)" [ZIP – 64.3 MB]**
   (February 2025 update). Unzip it — inside is the SAS transport file
   **`LLCP2023.XPT`** (combined landline and cell phone data, LLCP2023).
3. Also download the **2023 BRFSS Codebook** from the same page and verify
   all variable names and codes against it before running — start with
   `PROC CONTENTS`.
4. In `analysis.sas`, set the `LIBNAME ... XPORT` path to the folder
   holding `LLCP2023.XPT`. The program reads it directly with the XPORT
   engine; no conversion step is needed.

### Demo run (no download needed)

Run `analysis_demo.sas` instead — it imports the included simulated
sample `data/brfss2023_sample.csv` (n = 2,000, same variable names and
codes) and runs the same cleaning and modelling steps. Demo results are
simulated and must not be reported as BRFSS results; see
`data/README_sample.md`.

## Variables

| Variable | Role | Notes |
|---|---|---|
| `DIABETE4` | Outcome | Ever told diabetes |
| `_TOTINDA` | Exposure | Leisure-time physical activity |
| `_AGEG5YR` | Confounder | Age group |
| `SEX1` | Confounder | Sex |
| `_BMI5CAT` | Confounder | BMI category |
| `_EDUCAG` | Confounder | Education |
| `_INCOMG1` | Confounder | Income group |

Recode missing / refused / don't-know responses to missing. See `analysis.sas` for the recodes.

## How to run

**Demo (runs as-is, no download):** run `analysis_demo.sas` in SAS
OnDemand for Academics (free) or SAS Studio — it uses the included
simulated sample (see "Demo run" above).

**Real data:** in `analysis.sas`, set the `LIBNAME ... XPORT` path to
the folder holding your downloaded `LLCP2023.XPT`, then run the program
top to bottom.

## Analysis steps

1. Access and verify the data (`PROC CONTENTS`)
2. Data cleaning and validation (DATA step recodes, range and frequency checks)
3. Descriptive analysis (`PROC FREQ`, `PROC MEANS`)
4. Modelling (`PROC LOGISTIC` — unadjusted, then adjusted)
5. Quality control (check Ns at each step, compare unadjusted vs adjusted results)
6. Reporting (ODS output to tables and a one-page summary)

## Results

Results are in `results.md` — to be completed after running the program. No results are claimed before running.

## Limitations

Cross-sectional, self-reported data. No causal claim can be made from this analysis.

## Skills demonstrated

SAS DATA step, `PROC FREQ` / `PROC MEANS` / `PROC LOGISTIC`, data cleaning and validation, descriptive analysis, logistic regression, ODS reporting, quality control.
