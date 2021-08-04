## --------------------------------------------------------------------------
## Course: Exploratory Data Analysis - Project 1
## Author: Nivaldo Hydalgo
## Date..: 03/08/2021
## Object: Creating plot4.png
## --------------------------------------------------------------------------

# Run this script:
# source("plot4.R")
print("===> starting execution")


# Acquire the necessary library
library(dplyr)

# Set locale Date Time
Sys.setlocale("LC_TIME", "English")


# Create work directory, if it does not exist
if (!file.exists("data")) {
    dir.create("data")
}


# Download Dataset .zip file in external repository, if not exists
if (!file.exists("./data/household_power_consumption.zip")) {
    print("===> downloading file origin")
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip?accessType=DOWNLOAD"
    download.file(fileUrl, destfile = "./data/household_power_consumption.zip", 
                  method = "curl",
                  quiet = TRUE)
}


# Unzip Dataset containing "household_power_consumption.txt" in "data" directory
unzip(zipfile = "./data/household_power_consumption.zip", exdir = "./data")


# Read data filtering records containing column "Date" == "1/2/2007" or "2/2/2007"
household_power_consumption <- subset( 
    read.table("./data/household_power_consumption.txt", 
               header = TRUE, sep = ";", dec = ".", na.strings = "NA"), 
    Date %in% c("1/2/2007","2/2/2007") )


# Mutate content column for the correct class
household_power_consumption <- household_power_consumption %>% 
    mutate( datetime = strptime( paste(Date, Time) , format = "%d/%m/%Y %H:%M:%S", tz = "GMT"),
            Global_active_power = as.numeric(Global_active_power),
            Global_reactive_power = as.numeric(Global_reactive_power),
            Voltage = as.numeric(Voltage),
            Sub_metering_1 = as.numeric(Sub_metering_1),
            Sub_metering_2 = as.numeric(Sub_metering_2),
            Sub_metering_3 = as.numeric(Sub_metering_3) )


# Configure PNG device with 480 x 480 pixels
png("plot4.png", width = 480, height = 480, unit = "px")


# Configure the graphic with 4 areas
par(mfrow = c(2,2))


##-----------------------------------------------------------
##    graph plot: TOP LEFT
##-----------------------------------------------------------

# Plot graphics with the given definitions
plot(household_power_consumption$datetime, household_power_consumption$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power" )


##-----------------------------------------------------------
##    graph plot: TOP RIGHT
##-----------------------------------------------------------

# Plot graphics with the given definitions
plot(household_power_consumption$datetime, household_power_consumption$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage" )


##-----------------------------------------------------------
##    graph plot: BOTTOM LEFT
##-----------------------------------------------------------

# Plot graphics "Sub_metering_1" with the given definitions
plot(household_power_consumption$datetime, household_power_consumption$Sub_metering_1,
     type = "l",
     xlab = "",
     ylab = "Energy sub metering" )


# Plot graphics "Sub_metering_2" with the given definitions
points(household_power_consumption$datetime, household_power_consumption$Sub_metering_2, col="red", type = "l")


# Plot graphics "Sub_metering_2" with the given definitions
points(household_power_consumption$datetime, household_power_consumption$Sub_metering_3, col="blue", type = "l")


# Insert Legend and Close device
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))


##-----------------------------------------------------------
##    graph plot: BOTTOM RIGHT
##-----------------------------------------------------------

# Plot graphics with the given definitions
plot(household_power_consumption$datetime, household_power_consumption$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power" )


# Close devide print
dev.off()
print("===> finished execution")
