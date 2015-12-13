#unzip("exdata-data-household_power_consumption.zip")
library(sqldf)

powerdata <- read.csv.sql("household_power_consumption.txt", sql = "select * from file WHERE Date IN ('1/2/2007', '2/2/2007')", header = TRUE, sep = ';')
datetime <- strptime(paste(powerdata$Date, powerdata$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")
power <- cbind(powerdata, datetime)
rm(powerdata)

par(bg = "transparent")
hist(power$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot1.png")
dev.off()