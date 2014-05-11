#!/usr/bin/env Rscript


# Date extraction.
#d <- read.table("household_power_consumption.txt",
#                sep=";",
#                header=T)
#z <- as.Date(d$Date, format="%d/%m/%Y")

# Select only relevant dates
z1 <- z == as.Date("1/2/2007", format="%d/%m/%Y") |
      z == as.Date("2/2/2007", format="%d/%m/%Y")
d1 <- d[z1, ]

# Adding date time column to data frame.
d1$dt <- strptime(paste(d1$Date, d1$Time), "%d/%m/%Y %H:%M:%S")

# Open plotting device.
png(filename="./plot3.png",
       width=480,
      height=480,
       units="px",
          bg="white")

# Double type casting required to prevent casting to factor.
d1$Sub_metering_1 <- as.character(d1$Sub_metering_1)
d1$Sub_metering_1 <- as.numeric(d1$Sub_metering_1)
d1$Sub_metering_2 <- as.character(d1$Sub_metering_2)
d1$Sub_metering_2 <- as.numeric(d1$Sub_metering_2)
d1$Sub_metering_3 <- as.character(d1$Sub_metering_3)
d1$Sub_metering_3 <- as.numeric(d1$Sub_metering_3)
plot(d1$dt, d1$Sub_metering_1,
     xlab="",
     ylab="Energy sub metering",
     type="l")
lines(d1$dt, d1$Sub_metering_2, col="red")
lines(d1$dt, d1$Sub_metering_3, col="blue")

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lwd=1)

# Close open device.
dev.off()
