## --------------------------------------------------------------------------
## Course: Exploratory Data Analysis - Project 1
## Author: Nivaldo Hydalgo
## Date..: 01/08/2021
## Object: Creating plot2.png
## --------------------------------------------------------------------------

# Run this script:
# source("plot2.R")
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


# Mutate "Global_active_power" for numeric and create date/time variable "Date_Time"
household_power_consumption <- household_power_consumption %>% 
    mutate( Date_Time = strptime( paste(Date, Time) , format = "%d/%m/%Y %H:%M:%S", tz = "GMT"), 
        Global_active_power = as.numeric(Global_active_power) )


# Configure PNG device with 480 x 480 pixels
png("plot2.png", width = 480, height = 480, unit = "px")


# Plot graphics with the given definitions
plot(household_power_consumption$Date_Time, household_power_consumption$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)" )


# Close device
dev.off()


print("===> finished execution")
