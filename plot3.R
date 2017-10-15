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

png("plot3.png")

plot(x = dataset2$Datetime, 
     y = as.numeric(as.character(dataset2$Sub_metering_1)), 
     type="l",
     xlab = "",
     ylab = "Energy sub metering",
     col="black"
)

lines(x = dataset2$Datetime, 
     y = as.numeric(as.character(dataset2$Sub_metering_2)), 
     col="red"
)

lines(x = dataset2$Datetime, 
     y = as.numeric(as.character(dataset2$Sub_metering_3)), 
     col="blue"
)

legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lwd=1)

dev.off()