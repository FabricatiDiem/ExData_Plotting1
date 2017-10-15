#Download and unzip data if needed
dataset_source = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("dataset.zip")) download.file(dataset_source, "dataset.zip")
unzip("dataset.zip")

#Load required library
if(!require("data.table")) install.packages("data.table")
library(data.table)

#Load data and clean up dates
dataset = read.table("household_power_consumption.txt", header=TRUE, sep=";")
dataset$Date = as.Date(dataset$Date, "%d/%m/%Y")
dataset = subset(dataset, dataset$Date>='2007-02-01' & dataset$Date <'2007-02-03')

#Open output device
png("plot1.png")

#Plot histogram
hist(as.numeric(as.character(dataset$Global_active_power)), 
     main="Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     ylab="Frequency", 
     col="red")

#Close output device
dev.off()