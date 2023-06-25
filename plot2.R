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
household_power_consumption_data_plot2 <- read_delim("exdata_data_household_power_consumption/household_power_consumption.txt",
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
household_power_consumption_data_plot2 <- mutate(household_power_consumption_data_plot2, datetime = ymd_hms(paste(Date, Time)))

#Plotting plot 2
plot(Global_active_power ~ datetime, household_power_consumption_data_plot2, type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = NA)

#Saving plot 2 as png
dev.copy(png, "plot2.png",
         width  = 480,
         height = 480)

dev.off()

rm(list = ls())

