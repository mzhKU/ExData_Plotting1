#!/usr/bin/env Rscript


# Date extraction.
d <- read.table("household_power_consumption.txt",
                sep=";",
                header=T)
z <- as.Date(d$Date, format="%d/%m/%Y")

# Select only relevant dates
z1 <- z == as.Date("1/2/2007", format="%d/%m/%Y") |
      z == as.Date("2/2/2007", format="%d/%m/%Y")
d1 <- d[z1, ]

# Adding date time column to data frame.
d1$dt <- strptime(paste(d1$Date, d1$Time), "%d/%m/%Y %H:%M:%S")

# Open plotting device.
png(filename="./plot4.png",
       width=480,
      height=480,
       units="px",
          bg="white")

# Double type casting required to prevent casting to factor.
d1$Global_active_power <- as.character(d1$Global_active_power)
d1$Global_active_power <- as.numeric(d1$Global_active_power)
d1$Sub_metering_1 <- as.character(d1$Sub_metering_1)
d1$Sub_metering_1 <- as.numeric(d1$Sub_metering_1)
d1$Sub_metering_2 <- as.character(d1$Sub_metering_2)
d1$Sub_metering_2 <- as.numeric(d1$Sub_metering_2)
d1$Sub_metering_3 <- as.character(d1$Sub_metering_3)
d1$Sub_metering_3 <- as.numeric(d1$Sub_metering_3)
d1$Voltage <- as.character(d1$Voltage)
d1$Voltage <- as.numeric(d1$Voltage)
d1$Global_reactive_power <- as.character(d1$Global_reactive_power)
d1$Global_reactive_power <- as.numeric(d1$Global_reactive_power)

# Build plot.
par(mfrow=c(2,2))
plot(d1$dt, d1$Global_active_power,
     xlab="",
     ylab="Global Active Power",
     type="l")
plot(d1$dt, d1$Voltage, xlab="datetime", ylab="Voltage",
     type="l")
plot(d1$dt, d1$Sub_metering_1, xlab="", ylab="Energy sub metering",
     type="l")
lines(d1$dt, d1$Sub_metering_2, col="red")
lines(d1$dt, d1$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lwd=1)
plot(d1$dt, d1$Global_reactive_power, xlab="datetime", ylab="Global_reactive_power",
     type="l")


# Close open device.
dev.off()
