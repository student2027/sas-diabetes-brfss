# Results — to complete after running

Fill in after running `analysis.sas` (real BRFSS 2023 data) or
`analysis_demo.sas` (simulated sample) in SAS. Do not fill in before running.

## Sample

- Total N in BRFSS 2023 file (real run) / in the sample file (demo run, n = 2,000):
- N after cleaning (complete cases for outcome, exposure, and confounders):
- Diabetes prevalence (%):
- Physically active (%):

## Descriptive

| Variable | Diabetes % | n |
|---|---|---|
| Physically active | | |
| Not physically active | | |

## Logistic regression

Odds ratios are for physically active (active = 1) vs not active (active = 0).

| Model | Odds ratio | 95% CI | p-value |
|---|---|---|---|
| Unadjusted | | | |
| Adjusted (age, sex, BMI, education, income) | | | |

## What each run produces

- **Demo run (`analysis_demo.sas`):** imports the included simulated
  sample (`data/brfss2023_sample.csv`, n = 2,000) and runs the same
  cleaning and `PROC LOGISTIC` steps. Its numbers are SIMULATED and
  must not be reported as BRFSS results. As a cross-check, the
  equivalent R run on the identical sample
  (`r-diabetes-brfss`, `analysis.R`, demo mode, 22 Nov 2026) gave:
  unadjusted OR 0.61 (95% CI 0.44–0.85, p = 0.003) and adjusted OR
  0.58 (95% CI 0.42–0.82, p = 0.002), with diabetes prevalence 9.2%
  and 72.1% active. The SAS demo should give the same results on the
  same data and model — if it does not, check the recodes first.
  Note: the SAS demo itself has not been executed in this environment
  (no SAS installed here); run it in SAS OnDemand for Academics or
  SAS Studio and fill in the tables above from its output.
- **Real run (`analysis.sas`):** same tables, filled from the real
  BRFSS 2023 file (433,323 records). Replace any demo numbers with
  the real ones and delete the demo note.

## Interpretation (plain language)

_To be written after running._

## Limitations

Cross-sectional, self-reported data. No causal claim. Demo numbers
come from simulated data and must not be quoted as BRFSS results.
