setwd("C:/Users/divya/Documents/datasciencecoursera")
#Loading libraries
library(tidyverse)
library(lubridate)

#Loading Data
filename <- "household_power_consumption.zip"

if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, filename, method="curl")
}

# Checking if folder exists
if (!file.exists("exdata_data_household_power_consumption")) { 
  unzip(filename) 
}

#Loading data from 2007-02-01 and 2007-02-02
household_power_consumption_data_plot4 <- read_delim("exdata_data_household_power_consumption/household_power_consumption.txt",
                                                     delim = ";",
                                                     na=c("?"),
                                                     col_types = list(col_date(format = "%d/%m/%Y"),
                                                                      col_time(format = ""),
                                                                      col_number(),
                                                                      col_number(),
                                                                      col_number(),
                                                                      col_number(),
                                                                      col_number(),
                                                                      col_number(),
                                                                      col_number()
                                                     )) %>%
filter(between(Date, as.Date("2007-02-01"), as.Date("2007-02-02")))

# Combining date and time
household_power_consumption_data_plot4 <- mutate(household_power_consumption_data_plot4, datetime = ymd_hms(paste(Date, Time)))

#Saving plot 4 as png
dev.copy(png, "plot4.png",
         width  = 480,
         height = 480)

# Set graphics device to multiple figures with 2 rows and 2 columns
par(mfrow = c(2, 2))

#Plotting graph 1: top left
plot(Global_active_power ~ datetime, household_power_consumption_data_plot4, type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = NA)

#Plotting graph 2: top right
plot(Voltage ~ datetime, household_power_consumption_data_plot4, type = "l")

#Plotting graph 3: bottom left
plot(Sub_metering_1 ~ datetime, household_power_consumption_data_plot4, type = "l",
     ylab = "Energy sub metering",
     xlab = NA)

lines(Sub_metering_2 ~ datetime, household_power_consumption_data_plot4, type = "l", col = "red")

lines(Sub_metering_3 ~ datetime, household_power_consumption_data_plot4, type = "l", col = "blue")

legend("topright",col = c("black","red","blue"),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty = 1,
       bty = "n")

#Plotting graph 4: bottom right
plot(Global_reactive_power ~ datetime, household_power_consumption_data_plot4, type = "l")


dev.off()

rm(list = ls())
