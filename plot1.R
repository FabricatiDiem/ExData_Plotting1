dataset_source = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if(!file.exists("dataset.zip")) download.file(dataset_source, "dataset.zip")

unzip("dataset.zip")

if(!require("data.table")) install.packages("data.table")
library(data.table)

if(!require("sqldf")) install.packages("sqldf")
library(sqldf)

dataset = read.table("household_power_consumption.txt", header=TRUE, sep=";")
dataset$Date = as.Date(dataset$Date, "%d/%m/%Y")
dataset2 = subset(dataset, dataset$Date>='2007-02-01' & dataset$Date <'2007-02-03')

png("plot1.png")

hist(as.numeric(as.character(dataset2$Global_active_power)), main="Global Active Power", xlab = "Global Active Power (kilowatts)", ylab="Frequency", col="red")

dev.off()