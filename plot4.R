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

#Set plot for multiple subplots in 2x2 frame
par(mfrow=c(2,2))

#Open output device
png("plot4.png")

#Plot 1
plot(x = dataset2$Datetime, 
     y = as.numeric(as.character(dataset2$Global_active_power)), 
     type="l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)"
)

#Plot 2
plot(x = dataset2$Datetime,
     y = as.numeric(as.character(dataset2$Voltage)),
     type = "l",
     col="black",
     xlab = "datetime",
     ylab = "Voltage"
     )

#Plot 3
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

legend("topright", 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black", "red", "blue"), 
       lwd=1,
       bty="n"
       )

#Plot 4
plot(x = dataset2$Datetime, 
     y = as.numeric(as.character(dataset2$Global_reactive_power)), 
     type="l",
     xlab = "datetime",
     ylab = "Global_reactive_power",
     col="black"
)

#Close output device
dev.off()