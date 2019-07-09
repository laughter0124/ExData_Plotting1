library(lubridate)

# read data from the dates 2007-02-01 and 2007-02-02, saved in "data"
data0 <-
        read.table(
                "household_power_consumption.txt",
                header = TRUE,
                sep = ";",
                colClasses = c("factor", rep("NULL", 8))
        )
date <- as.Date(dmy(data0$Date))
pos <- which(date == "2007-02-01" | date == "2007-02-02")

data <-
        read.table(
                "household_power_consumption.txt",
                col.names = colnames(
                        read.table(
                                "household_power_consumption.txt",
                                nrow = 1,
                                header = TRUE,
                                sep = ";"
                        )
                ),
                sep = ";",
                skip = pos[1],
                nrow = length(pos)
        )
data$Time <-
        strptime(paste(data$Date, data$Time), format = "%d/%m/%Y%H:%M:%S")
data$Date <- as.Date(dmy(data$Date))

# plotting
png("plot3.png")
plot(
        data$Time,
        data$Sub_metering_1,
        type = "l",
        xlab = "",
        ylab = "Energy sub metering"
)
points(data$Time,
       data$Sub_metering_2,
       type = "l",
       col = "red")
points(data$Time,
       data$Sub_metering_3,
       type = "l",
       col = "blue")
legend(
        "topright",
        lty = 1,
        col = c("black", "red", "blue"),
        c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
)
dev.off()