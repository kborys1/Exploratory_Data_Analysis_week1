library(data.table)
library(anytime)

dt <- fread("household_power_consumption_2days.txt")
### new datetime column t, convert numeric columns 
dt[,t := anytime(paste(Date,Time))]
strTmp <- c("Global_active_power","Global_reactive_power", "Voltage", 
            "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
dt[, (strTmp) := lapply(.SD, as.numeric), .SDcols = strTmp]


###############################################################################
#draw graphs
#1
par(mfrow=c(1,1))
hist(dt$Global_active_power, col = "red", xlab="Global Active Power (kilowatts)",
     main="Global Active Power")
dev.copy(png, file = "graph1.png")
dev.off()
#2
par(mfrow=c(1,1))
plot(dt$t, dt$Global_active_power, type="n",  
     ylab = "Global Active Power (kilowatts)", xlab ="")
lines(dt$t, dt$Global_active_power, type = "l")
dev.copy(png, file = "graph2.png")
dev.off()

#3
par(mfrow=c(1,1))
plot(dt$t, dt$Sub_metering_1, type="n", ylab = "Energy sub metering", xlab = "")
lines(dt$t, dt$Sub_metering_1, type = "l")
lines(dt$t, dt$Sub_metering_2, type = "l", col = "red")
lines(dt$t, dt$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, file = "graph3.png")
dev.off()
#4
par(mfrow=c(2,2))
plot(dt$t, dt$Global_active_power, type="n", ylab = "Global Active Power (kilowatts)", xlab = "")
lines(dt$t, dt$Global_active_power, type = "l")
plot(dt$t, dt$Voltage, type="n", ylab = "Voltage", xlab = "")
lines(dt$t, dt$Voltage, type = "l")
plot(dt$t, dt$Sub_metering_1, type="n", ylab = "Energy sub metering", xlab = "")
lines(dt$t, dt$Sub_metering_1, type = "l")
lines(dt$t, dt$Sub_metering_2, type = "l", col = "red")
lines(dt$t, dt$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(dt$t, dt$Global_reactive_power, type="n",  
     ylab = "Global_reactive_power", xlab = "")
lines(dt$t, dt$Global_reactive_power, type = "l")
dev.copy(png, file = "graph4.png")
dev.off()

