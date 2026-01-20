This repository provides a walkthrough of the **Box-Jenkins methodology** using R. It covers the four essential stages of the methodology: identification, estimation, diagnostic Checking, and forecasting.

## 📈 Methodology Overview
The script demonstrates how to:
1. **Identify** stationarity using the Augmented Dickey-Fuller (ADF) test.
2. **Transform** data using differencing to achieve stationarity.
3. **Analyze** ACF and PACF plots to determine ARIMA parameters.
4. **Fit** an ARIMA(2,1,0) model with drift.
5. **Validate** the model using the residual time plot and the Ljung-Box test.
6. **Forecast** 40 steps ahead with confidence intervals.

## 🛠️ Requirements
To run this script, install the following packages in R:
- `ggplot2` (Visualization)
- `tseries` (Statistical tests)
- `forecast` (ARIMA modeling)
