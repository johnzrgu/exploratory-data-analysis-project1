## open library
library(dplyr)
library(tidyr)
library(readr)
## Download and unzip file
Origin_dir <- getwd()
if(!file.exists('exdata_data_household_power_consumption.zip')){
  download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', 'exdata_data_household_power_consumption.zip')
}

unzip('exdata_data_household_power_consumption.zip')
## Read and transform data
consumptiondata <- read.table('household_power_consumption.txt', header = TRUE, sep = ";")
consumptiondata$Date1 <- as.Date(consumptiondata$Date, "%d/%m/%Y")

plotdata <- filter(consumptiondata, Date1 >= '2007-02-01' & Date1 <= '2007-02-02')
plotdata[3:9] <- sapply(plotdata[3:9], as.numeric)

plotdata$DateTime <- strptime(paste(plotdata$Date, plotdata$Time, sep = " "), "%d/%m/%Y %H:%M:%S")

## turn on png
png(filename = "plot4.png", width = 480, height = 480, units = "px")

## plot
par(mfrow = c(2,2), mar = c(4, 4, 2, 1), oma = c(0,0,2,0))

with(plotdata, {
                 plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power");
                 plot(DateTime, Voltage, type = "l", ylab = "Voltage", xlab = "datetime");


                 plot(DateTime, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering");
                 lines(DateTime, Sub_metering_1);  
                 lines(DateTime, Sub_metering_2, col = "red");
                 lines(DateTime, Sub_metering_3, col = "blue");
                 legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"));


                 plot(DateTime, plotdata$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")
})




## turn off dev
dev.off()