library("data.table")
setwd("C:/Users/daniel.deneve/Desktop/R Programming/Coursera/Exploratory Data Analysis/Project 1")
getwd()

#This reads the data from the file then creates subset data for specified dates
powerconsumptionDT <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

# This restricts use of scientific notation
powerconsumptionDT[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# This makes a POSIXct date capable of being filtered and graphed by time of day
powerconsumptionDT[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# This Filter Dates from 2007-02-01 to 2007-02-02
powerconsumptionDT <- powerconsumptionDT[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot2.png", width=480, height=480)

## Creation of Plot 2
plot(x = powerconsumptionDT[, dateTime]
     , y = powerconsumptionDT[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()