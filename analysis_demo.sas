/* ==========================================================================
   Physical Activity and Diabetes Prevalence in US Adults — DEMO RUN
   SAS analysis of a SIMULATED BRFSS-style sample (n = 2000)
   --------------------------------------------------------------------------
   DEMO ONLY. This program runs end-to-end with no download: it imports
   data/brfss2023_sample.csv, a simulated dataset with the same variable
   names and BRFSS 2023 codes as the real data (generated with a known,
   invented association — see data/README_sample.md). Its results are
   SIMULATED and must NOT be reported as real BRFSS results.
   For the real analysis, run analysis.sas on the real BRFSS 2023 file
   (see README.md, "Get the real data").
   Run in SAS OnDemand for Academics (free) or SAS Studio, top to bottom.
   Update the path in PROC IMPORT to where you cloned this repo.
   ========================================================================== */

/* Step 1: Access and verify — import the simulated sample */
proc import datafile="data/brfss2023_sample.csv"
    out=work.llcp2023_sample
    dbms=csv replace;
    getnames=yes;
run;

proc contents data=work.llcp2023_sample order=varlist;
run;

/* Step 2: Data cleaning and validation — same recodes as analysis.sas */
data work.brfss_clean;
    set work.llcp2023_sample;

    /* Outcome: ever told diabetes.
       Recode missing / refused / don't-know to missing.
       DIABETE4 = 3 (pre-diabetes) and 4 (gestational) are set to missing
       here, so the outcome is diabetes (1) vs no diabetes (2) only. */
    if DIABETE4 in (1) then diabetes = 1;
    else if DIABETE4 in (2) then diabetes = 0;
    else diabetes = .;

    /* Exposure: leisure-time physical activity */
    if _TOTINDA in (1) then active = 1;
    else if _TOTINDA in (2) then active = 0;
    else active = .;

    /* Confounders: keep as coded in BRFSS; set missing codes to . */
    if _AGEG5YR in (14) then agegrp = .; else agegrp = _AGEG5YR;
    if SEX1 in (9) then sex = .; else sex = SEX1;
    if missing(_BMI5CAT) then bmi_cat = .; else bmi_cat = _BMI5CAT;
    if _EDUCAG in (9) then educ = .; else educ = _EDUCAG;
    if _INCOMG1 in (9) then income = .; else income = _INCOMG1;
run;

proc freq data=work.brfss_clean;
    tables diabetes active agegrp sex bmi_cat educ income / missing;
run;

/* Step 3: Descriptive analysis */
proc freq data=work.brfss_clean;
    tables diabetes*active diabetes*agegrp diabetes*sex
             diabetes*bmi_cat diabetes*educ diabetes*income / chisq;
run;

proc means data=work.brfss_clean n nmiss mean std min max;
    var agegrp;
run;

/* Step 4: Modelling - logistic regression */
proc logistic data=work.brfss_clean;
    class active (ref="0") / param=ref;
    model diabetes(event="1") = active;
    oddsratio active;
    title "DEMO (simulated data) — Unadjusted: diabetes by physical activity";
run;

proc logistic data=work.brfss_clean;
    class active (ref="0") agegrp sex bmi_cat educ income / param=ref;
    model diabetes(event="1") = active agegrp sex bmi_cat educ income;
    oddsratio active;
    title "DEMO (simulated data) — Adjusted: diabetes by physical activity";
run;

/* Step 5: Quality control - check Ns at each step and compare
   unadjusted vs adjusted results before reporting. */

/* Step 6: Reporting */
ods pdf file="diabetes_physical_activity_results_demo.pdf";
proc freq data=work.brfss_clean;
    tables diabetes*active / chisq;
run;
ods pdf close;
