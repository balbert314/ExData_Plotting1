library(dplyr)

if (!exists("powerdata")) {
  read.table("household_power_consumption.txt", nrows=-1, sep=";", header=TRUE, na.strings = "?", stringsAsFactors=FALSE) -> powerdata
  paste(powerdata$Date, powerdata$Time) -> powerdata$DateTime
  as.POSIXct(powerdata$DateTime, format = "%d/%m/%Y %H:%M:%S") -> powerdata$DateTime
  filter(powerdata, DateTime >= as.POSIXct("2007-02-01 00:00:00"), DateTime < as.POSIXct("2007-02-03 00:00:00")) -> powerdata
  as.Date(powerdata$Date, format="%d/%m/%Y") -> powerdata$Date
}

png(filename="plot2.png",width=480,height=480,units="px")
plot(powerdata$DateTime,powerdata$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "n")
lines(powerdata$DateTime,powerdata$Global_active_power)
dev.off()
