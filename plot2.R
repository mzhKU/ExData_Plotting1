#!/usr/bin/env Rscript

# **********************************************
# Set local language
Sys.setlocale("LC_TIME", "English")
# ----------------------------------------------




# **********************************************
# Date extraction.
# ----------------------------------------------
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
png(filename="./plot2.png",
       width=480,
      height=480,
       units="px",
          bg="white")

# Double type casting required, else 'Global_active_power' results
# in a factor.
d1$Global_active_power <- as.character(d1$Global_active_power)
d1$Global_active_power <- as.numeric(d1$Global_active_power)
plot(d1$dt, d1$Global_active_power,
     xlab="",
     ylab="Global Active Power (kilowatts)",
     type="l")

# Close open device.
dev.off()
