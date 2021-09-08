
library("data.table")


setwd("C:/Users/daniel.deneve/Desktop/R Programming/Coursera/Exploratory Data Analysis/Project 1")
getwd()

#This will call the data from the file then subset the data for specified dates
powerconsumptionDT <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

# This is for aesthetics, prevents the histogram from using scientific notation
powerconsumptionDT[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# This changes the Date Column to Date Type
powerconsumptionDT[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# This Filters dates from 2007-02-01 to 2007-02-02
powerconsumptionDT <- powerconsumptionDT[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

png("plot1.png", width=480, height=480)

## The creation of Plot 1 (histogram)
hist(powerconsumptionDT[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()