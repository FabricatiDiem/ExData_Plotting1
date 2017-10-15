#Download and unzip data
dataset_source = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("dataset.zip")) download.file(dataset_source, "dataset.zip")
unzip("dataset.zip")

#Load required library
if(!require("data.table")) install.packages("data.table")
library(data.table)

#Load data; prepare and clean datetime
dataset = read.table("household_power_consumption.txt", header=TRUE, sep=";")
dataset$Datetime = paste(dataset$Date, dataset$Time)
dataset$Datetime = as.POSIXct(dataset$Datetime, format="%d/%m/%Y %H:%M:%S")
dataset2 = subset(dataset, dataset$Datetime>='2007-02-01' & dataset$Datetime <'2007-02-03')

#Open output device
png("plot3.png")

#Create initial plot and draw first variable
plot(x = dataset2$Datetime, 
     y = as.numeric(as.character(dataset2$Sub_metering_1)), 
     type="l",
     xlab = "",
     ylab = "Energy sub metering",
     col="black"
)

#Draw second variable on existing plot
lines(x = dataset2$Datetime, 
     y = as.numeric(as.character(dataset2$Sub_metering_2)), 
     col="red"
)

#Draw third variable on existing plot
lines(x = dataset2$Datetime, 
     y = as.numeric(as.character(dataset2$Sub_metering_3)), 
     col="blue"
)

#Draw legend on existing plot
legend("topright", 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black", "red", "blue"), 
       lwd=1
       )

#Close output device
dev.off()