library(lubridate)

data <- read.table("household_power_consumption.txt"  , sep = ";" , header = TRUE)

data$Date <- dmy(data$Date) 


Subdata <- subset(data , c(Date == '2007-02-02' |  Date == '2007-02-01'))

Subdata$Global_active_power <- gsub("?",NA, Subdata$Global_active_power , fixed =TRUE)
Subdata$Global_reactive_power <- gsub("?",NA, Subdata$Global_reactive_power , fixed =TRUE)
Subdata$Voltage <- gsub("?",NA, Subdata$Voltage , fixed =TRUE)
Subdata$Sub_metering_1 <- gsub("?",NA, Subdata$Sub_metering_1 , fixed =TRUE)
Subdata$Sub_metering_2 <- gsub("?",NA, Subdata$Sub_metering_2 , fixed =TRUE)
Subdata$Sub_metering_3 <- gsub("?",NA, Subdata$Sub_metering_3 , fixed =TRUE)

Subdata[,3:9] <- sapply(Subdata[,3:9],as.numeric)

Subdata$combine <- strptime(paste(Subdata$Date, Subdata$Time, sep=" "), "%Y-%m-%d %H:%M:%S")


jpeg(file = "plot4.jpeg", width = 480, height = 480, units = "px")

par(mfrow = c(2,2) , mar = c(4,4,2,1))

plot(Subdata$combine, Subdata$Global_active_power , type = "l" , xlab = "" 
     , ylab = "Global Active Power (kilowatts)")

plot(Subdata$combine, Subdata$Voltage , type = "l" , xlab = "datetime" 
     , ylab = "Voltage")

with(Subdata, plot(combine, Sub_metering_1  , type = "n" , ylab = ""))
with(Subdata, lines(combine, Sub_metering_1 ))
with(Subdata, lines(combine, Sub_metering_2, col = "red" ))
with(Subdata, lines(combine, Sub_metering_3, col = "blue" ))
legend("topright" , col = c("black" , "red" , "blue") , lty = 1, cex = 0.9 , lwd = 1 
       ,legend = c("Sub_metering_1", "Sub_metering_2" ,"Sub_metering_3"))

plot(Subdata$combine, Subdata$Global_reactive_power , type = "l" , xlab = "datetime" 
     , ylab = "Global_reactive_power")

dev.off()
