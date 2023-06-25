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
household_power_consumption_data <- read_delim("exdata_data_household_power_consumption/household_power_consumption.txt",
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

#Plotting the histogram
hist(household_power_consumption_data$Global_active_power,
     xlab = "Global Active Power (kilowatts)",
     col  = "red",
     main = "Global Active Power")

#Saving the histogram
dev.copy(png, "plot1.png",
         width  = 480,
         height = 480)

dev.off()

rm(list = ls())
