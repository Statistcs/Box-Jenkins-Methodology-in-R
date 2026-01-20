#Installing the necessary packages:
install.packages("ggplot2")
library(ggplot2)
install.packages("tseries")
library(tseries)
install.packages("forecast")
library(forecast)

#Creating the time series dataset:
time = c(1:100)
ts_data = c(51.4, 51.7, 52.3, 51.1, 51.4, 52.7, 51.7, 50.3, 51.6, 52.7, 54.8, 55.0, 55.5, 54.3, 52.9, 
          53.5, 54.0, 51.9, 53.9, 54.5, 54.8, 55.1, 56.0, 56.5, 55.5, 56.9, 58.5, 59.8, 61.3, 62.1, 
          62.6, 64.8, 66.7, 67.8, 70.6, 71.1, 72.5, 73.0, 74.2, 75.9, 76.3, 77.3, 79.7, 82.0, 83.2, 
          83.5, 85.8, 86.8, 88.3, 90.6, 92.1, 93.2, 94.6, 94.3, 96.0, 95.6, 94.5, 94.3, 94.6, 94.9, 
          94.9, 96.3, 98.2, 98.4, 100.1, 99.9, 100.3, 100.8, 101.5, 100.8, 100.8, 100.9, 101.9, 
          104.1, 107.8, 110.0, 113.0, 115.3, 116.1, 118.2, 117.7, 118.5, 118.0, 118.2, 115.3, 
          113.3, 111.9, 111.1, 109.4, 110.6, 110.2, 111.6, 111.8, 110.1, 108.6, 107.9, 107.4, 
          106.9, 108.0, 108.8)

#Plotting the data: 
ggplot()+
  geom_line(aes(x = time,y = ts_data))+
  xlab("Time")+
  ylab("Value")+
  ggtitle("Simulated Time Series")+
  scale_x_continuous(breaks = seq(0, 100, by=20)) +     
  scale_y_continuous(breaks = seq(50, 150, by=20))+
  theme(
    plot.title = element_text(face = "bold"),
    axis.title.x = element_text(face = "bold"),
    axis.title.y = element_text(face = "bold")
  )

#Testing the data for stationarity:
adf.test(ts_data)

#Differencing the data:
diff_data = diff(ts_data)

#Retesting the data stationarity:
adf.test(diff_data)

#Plotting the differenced series:
ggplot()+
  geom_line(aes(x = time[1:99],y = diff_data))+
  xlab("Time")+
  ylab("Value")+
  ggtitle("Differenced Time Series")+
  theme(
    plot.title = element_text(face = "bold"),
    axis.title.x = element_text(face = "bold"),
    axis.title.y = element_text(face = "bold")
  )

#Creating the ACF plot of the differenced series:
acf(diff_data, main = "ACF Plot of Differenced Series", lag.max = 12)

#Creating the PACF plot of the differenced series:
pacf(diff_data, main = "PACF Plot of Differenced Series", lag.max = 12)

#Fitting the ARIMA model:
my_arima = Arima(ts_data, order=c(2,1,0), include.drift=TRUE)
summary(my_arima)

#Creating a time plot of residuals:
residuals_arima = residuals(my_arima)
ggplot(mapping=aes(x=time,y=residuals_arima))+
  geom_point()+
  xlab("Time")+
  ylab("Residuals")+
  ggtitle("Residuals vs. Time")+
  theme(
    plot.title = element_text(face = "bold"),
    axis.title.x = element_text(face = "bold"),
    axis.title.y = element_text(face = "bold")
  )

#Conducting the Ljung-Box test of residuals:
Box.test(residuals_arima, lag = 20, type = "Ljung-Box")

#Generating a 10-step-ahead forecast:
arima_forecast = forecast(my_arima, h = 40)

#Plotting the forecast using autoplot (ggplot2):
autoplot(arima_forecast) +
  xlab("Time") +
  ylab("Value") +
  ggtitle("40-Step-Ahead Forecast from ARIMA(2,1,0)")+
  theme(
    plot.title = element_text(size = 11, face = "bold")
  )












