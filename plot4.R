library(dplyr)

if (!exists("powerdata")) {
  read.table("household_power_consumption.txt", nrows=-1, sep=";", header=TRUE, na.strings = "?", stringsAsFactors=FALSE) -> powerdata
  paste(powerdata$Date, powerdata$Time) -> powerdata$DateTime
  as.POSIXct(powerdata$DateTime, format = "%d/%m/%Y %H:%M:%S") -> powerdata$DateTime
  filter(powerdata, DateTime >= as.POSIXct("2007-02-01 00:00:00"), DateTime < as.POSIXct("2007-02-03 00:00:00")) -> powerdata
  as.Date(powerdata$Date, format="%d/%m/%Y") -> powerdata$Date
}

png(filename="plot4.png",width=480,height=480,units="px")
par(mfrow = c(2,2))
#Top left graph
plot(powerdata$DateTime,powerdata$Global_active_power, xlab = "", ylab = "Global Active Power", type = "n")
lines(powerdata$DateTime,powerdata$Global_active_power)
#Top right graph
plot(powerdata$DateTime,powerdata$Voltage,xlab="datetime",ylab="Voltage",type="n")
lines(powerdata$DateTime,powerdata$Voltage)
#Bottom left graph
plot(powerdata$DateTime,powerdata$Sub_metering_1,xlab="",ylab="Energy sub metering",type="n")
lines(powerdata$DateTime,powerdata$Sub_metering_1,col="black")
lines(powerdata$DateTime,powerdata$Sub_metering_2,col="red")
lines(powerdata$DateTime,powerdata$Sub_metering_3,col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c("black","red","blue"),bty="n")
#Bottom right graph
plot(powerdata$DateTime,powerdata$Global_reactive_power,xlab="datetime",ylab="Global_reactive_power",type="n")
lines(powerdata$DateTime,powerdata$Global_reactive_power)
dev.off()
