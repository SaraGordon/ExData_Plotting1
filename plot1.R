setwd("/Users/saragordon/data")
library(dplyr)
library(lubridate)

##Read everything then subset
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
allData <- read.table(unz(temp, "household_power_consumption.txt"), header = FALSE, sep = ";", dec = ".")
unlink(temp)

names(allData) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

data <- subset(allData, Date == "1/2/2007" | Date == "2/2/2007")

##Convert Date and Time to date/time classes
data$Date <- dmy(data$Date)
data$Time <- strptime(data$Time, format = "%H:%M:%S")

##Convert everything else to numeric
data$Global_active_power <- as.numeric(data$Global_active_power, na.rm = TRUE)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power, na.rm = TRUE)
data$Voltage <- as.numeric(data$Voltage, na.rm = TRUE)
data$Global_intensity <- as.numeric(data$Global_intensity, na.rm = TRUE)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1, na.rm = TRUE)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2, na.rm = TRUE)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3, na.rm = TRUE)

#Create a histogram of Global Active Power
##Set the color, title and x-axis label
hist(data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

##Create the PNG file and then turn off the device
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()
