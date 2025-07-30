# Causal-Discovery-for-industry
This is code and data for research paper: Spatio-Temporal Causal Network Analysis for Complex Industry System with Cycle Heterogeneity

The main code include two .ipynb files and one stata .do file: 

- investment clock.ipynb is for creating merrill lynch using china's cpi and actual gdp.

- index2networkpanel.ipynb is for causal discovery of cyclical industry's log_returns timeseries sliced by investment clock, after reconstructing the causal graph of sliced timeseries, the code transform them into network panel, which will be output as final_panel_data_with_factors_and_phase.csv

- After the causal graph created by index2networkpanel.ipynb, the logistic regression0105.do file complete the link prediction mission by logistic regression.
