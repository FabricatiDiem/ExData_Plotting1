dataset_source = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if(!file.exists("dataset.zip")) download.file(dataset_source, "dataset.zip")

unzip("dataset.zip")

if(!require("data.table")) install.packages("data.table")
library(data.table)

if(!require("sqldf")) install.packages("sqldf")
library(sqldf)

dataset = read.table("household_power_consumption.txt", header=TRUE, sep=";")
dataset$Datetime = paste(dataset$Date, dataset$Time)
dataset$Datetime = as.POSIXct(dataset$Datetime, format="%d/%m/%Y %H:%M:%S")
dataset2 = subset(dataset, dataset$Datetime>='2007-02-01' & dataset$Datetime <'2007-02-03')

png("plot2.png")

plot(x = dataset2$Datetime, 
     y = as.numeric(as.character(dataset2$Global_active_power)), 
     type="l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)"
     )

dev.off()