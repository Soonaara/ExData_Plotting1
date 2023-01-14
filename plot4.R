##load power consumption dataset
power_con <- read.table("household_power_consumption.txt",skip=1,sep=";")
names(power_con) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

##Merge time and date columns
TimeDate <- strptime(paste(power_con$Date, power_con$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
power_con <- cbind(power_con, TimeDate)

##Subsetting needed data
subpower_con <- subset(power_con,power_con$Date=="1/2/2007" | power_con$Date =="2/2/2007")

##Initiating a composite plot with mant graphs
par(mfcol = c(2, 2))

##Plot functions
with(subpower_con, plot(TimeDate, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))

with(subpower_con, plot(TimeDate, Sub_metering_1, type="n", xlab="", ylab="Energy Sub metering"))
lines(subpower_con$TimeDate, subpower_con$Sub_metering_1)
lines(subpower_con$TimeDate, subpower_con$Sub_metering_2, col = "red")
lines(subpower_con$TimeDate, subpower_con$Sub_metering_3, col = "blue")
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = .3, bty="n")

with(subpower_con, plot(TimeDate, Voltage, type="l", xlab="datetime", ylab="Voltage"))

with(subpower_con, plot(TimeDate, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power"))

# annotating graph:
dev.copy(png,"plot4.png", width=480, height=480)
dev.off()