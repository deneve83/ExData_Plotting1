library("data.table")
setwd("C:/Users/daniel.deneve/Desktop/R Programming/Coursera/Exploratory Data Analysis/Project 1")
getwd()


#This reads in data from the file then creates subsets for specified dates
powerconsumptionDT <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

# Prevents Scientific Notation
powerconsumptionDT[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Making a POSIXct date capable of being filtered and graphed by time of day
powerconsumptionDT[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# This filters dates from 2007-02-01 to 2007-02-02
powerconsumptionDT <- powerDT[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot3.png", width=480, height=480)

# This creates Plot 3
plot(powerconsumptionDT[, dateTime], powerDT[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(powerconsumptionDT[, dateTime], powerDT[, Sub_metering_2],col="red")
lines(powerconsumptionDT[, dateTime], powerDT[, Sub_metering_3],col="blue")
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))

dev.off()