# set the working directory
#setwd("~/Coursea/Explore")

#set the intitial classes for the imported columns 
hdr.classes <- c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")

# load the household power data into memory
data <- read.table("household_power_consumption.txt", header = TRUE, colClasses = hdr.classes,sep = ";", stringsAsFactors = FALSE, na.strings = "?")

# remove all but the first 2 days in February
library(dplyr)
data <- filter(data, Date %in% c("1/2/2007","2/2/2007"))

# convert date and time to Date/Time classes
data <- transform(data, Date = as.Date(Date, format='%d/%m/%Y'), Time = strptime(paste(Date,Time), format='%d/%m/%Y %H:%M:%S'))

# open a png graphical device
png(file="plot4.png", width = 480, height=480)

#par(mar= c(5,4,4,2) + 0.1)
par(mfcol=c(2,2), mar= c(4,4,2,1), oma=c(1,0,2,1))
with(data, plot(Time, Global_active_power, xlab = "", ylab="Global ActivePower", type="l"))
with(data, plot(Time, Sub_metering_1, xlab = "", ylab="Energy sub metering", type="l"))
with(data, lines(Time, Sub_metering_2, type = "l", col="red"))
with(data, lines(Time, Sub_metering_3, type = "l", col="blue"))
legend("topright", lwd = 1 , col =c("black","red","blue"),legend = names(data)[7:9], bty = "n")
with(data, plot(Time, Voltage, xlab = "datetime", type="l"))
with(data, plot(Time, Global_reactive_power, xlab = "datetime", type="l"))
dev.off()
