## read data
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
consumptiondata <- read.table('household_power_consumption.txt', header = TRUE, sep = ";", stringsAsFactors = FALSE)
consumptiondata$Date1 <- as.Date(consumptiondata$Date, "%d/%m/%Y")

plotdata <- filter(consumptiondata, Date1 >= '2007-02-01' & Date1 <= '2007-02-02')
plotdata[3:9] <- sapply(plotdata[3:9], as.numeric)

plotdata$DateTime <- strptime(paste(plotdata$Date, plotdata$Time, sep = " "), "%d/%m/%Y %H:%M:%S")

## turn on png
png(filename = "plot1.png", width = 480, height = 480, units = "px")

## plot
hist(plotdata$Global_active_power, col = "red", xlab = "Global Active Power (Kilowatts)", main = "Global Active Power")

## turn off dev
dev.off()