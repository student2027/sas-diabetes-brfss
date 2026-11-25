/* ==========================================================================
   Physical Activity and Diabetes Prevalence in US Adults
   SAS analysis of CDC BRFSS 2023 data
   --------------------------------------------------------------------------
   HOW TO RUN
   -----------
   REAL DATA (recommended): download the real BRFSS 2023 file — see
   README.md, "Get the real data". Unzip it to get LLCP2023.XPT, then
   set the LIBNAME below to its folder. The XPORT engine reads the
   SAS transport file directly.
   DEMO (runs as-is, no download): run analysis_demo.sas instead — it
   imports the included simulated sample, data/brfss2023_sample.csv
   (n = 2000, same variable names/codes as BRFSS 2023), and runs the
   same cleaning and modelling steps. Demo results are SIMULATED and
   must not be reported as BRFSS results.
   ========================================================================== */

/* Step 1: Access and verify */
/* Real BRFSS 2023 file: update the path to the folder holding LLCP2023.XPT */
libname brfss XPORT "YOUR/BRFSS/PATH/LLCP2023.XPT";

proc contents data=brfss.llcp2023 order=varlist;
run;

/* Step 2: Data cleaning and validation */
data work.brfss_clean;
    set brfss.llcp2023;

    /* Outcome: ever told diabetes.
       Recode missing / refused / don't-know to missing.
       Exclude gestational diabetes and pre-diabetes as appropriate
       for your research question; document the choice here. */
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
    title "Unadjusted: diabetes by physical activity";
run;

proc logistic data=work.brfss_clean;
    class active (ref="0") agegrp sex bmi_cat educ income / param=ref;
    model diabetes(event="1") = active agegrp sex bmi_cat educ income;
    oddsratio active;
    title "Adjusted: diabetes by physical activity";
run;

/* Step 5: Quality control - check Ns at each step and compare
   unadjusted vs adjusted results before reporting. */

/* Step 6: Reporting */
ods pdf file="diabetes_physical_activity_results.pdf";
proc freq data=work.brfss_clean;
    tables diabetes*active / chisq;
run;
ods pdf close;
