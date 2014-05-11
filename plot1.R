#!/usr/bin/env Rscript

# **********************************************
# Plotting
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

# Open plotting device.
png(filename="./plot1.png",
       width=480,
      height=480,
       units="px",
          bg="white")

# Double type casting required, else 'Global_active_power' results
# in a factor.
d1$Global_active_power <- as.character(d1$Global_active_power)
d1$Global_active_power <- as.numeric(d1$Global_active_power)
hist(d1$Global_active_power,
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency",
     main="Global Active Power",
      col="red")

# Close open device.
dev.off()
