# Demo sample data — SIMULATED, not real BRFSS data

`brfss2023_sample.csv` (n = 2,000 rows) is a **simulated** dataset created
only so the analysis can be run end-to-end without downloading the
433,323-row real BRFSS 2023 file. It was generated in Python
(`numpy.random.default_rng(2023)`) with the same variable names and the same
BRFSS 2023 codes as the real data:

- `DIABETE4`: 1 = told diabetes, 2 = not told, 3 = pre-diabetes, 9 = refused
- `_TOTINDA`: 1 = physically active, 2 = not active, 9 = don't know/refused
- `_AGEG5YR`: 1 (18–24) … 13 (80+), 14 = don't know/refused
- `SEX1`: 1 = male, 2 = female, 9 = refused
- `_BMI5CAT`: 1 = underweight, 2 = normal, 3 = overweight, 4 = obese
- `_EDUCAG`: 1–4 (education groups), 9 = refused
- `_INCOMG1`: 1–8 (income groups), 9 = don't know/refused

Diabetes in the sample was generated with a known (invented) association:
risk rises with physical inactivity, older age group, and higher BMI
category. That is why the demo run shows an odds ratio above 1 for
inactivity — it is a property of the simulation, **not a real finding**.

In SAS, import it with `PROC IMPORT` (see `analysis_demo.sas`) or point
`analysis.sas` at the real BRFSS 2023 file (see the main README.md,
"Get the real data"). Do not report the demo numbers as BRFSS results.
