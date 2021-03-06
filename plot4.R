#unzip("exdata-data-household_power_consumption.zip")
library(sqldf)

powerdata <- read.csv.sql("household_power_consumption.txt", sql = "select * from file WHERE Date IN ('1/2/2007', '2/2/2007')", header = TRUE, sep = ';')
datetime <- strptime(paste(powerdata$Date, powerdata$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")
power <- cbind(powerdata, datetime)
rm(powerdata)

par(mfrow = c(2,2), mar = c(4,4,2,1), bg = "transparent", cex = 0.7)
with(power, {
  plot(datetime, Global_active_power, xlab = "", ylab = "Global Active Power", type = "l")
  plot(datetime, Voltage, type = "l")
  plot(datetime, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l")
  lines(power$datetime, power$Sub_metering_2, col = "red")
  lines(power$datetime, power$Sub_metering_3, col = "blue")
  legend("topright", col = c("black", "red", "blue"), lty=1, bty = "n", cex = 0.6, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(datetime, Global_reactive_power, type = "l")
})

dev.copy(png, file = "plot4.png")
dev.off()