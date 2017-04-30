library(lubridate)

data <- read.table("household_power_consumption.txt"  , sep = ";" , header = TRUE)

data$Date <- dmy(data$Date) 

Subdata <- subset(data , c(Date == '2007-02-02' |  Date == '2007-02-01'))

Subdata$Sub_metering_1 <- gsub("?",NA, Subdata$Sub_metering_1 , fixed =TRUE)
Subdata$Sub_metering_2 <- gsub("?",NA, Subdata$Sub_metering_2 , fixed =TRUE)
Subdata$Sub_metering_3 <- gsub("?",NA, Subdata$Sub_metering_3 , fixed =TRUE)

Subdata[,3:9] <- sapply(Subdata[,3:9],as.numeric)

Subdata$combine <- strptime(paste(Subdata$Date, Subdata$Time, sep=" "), "%Y-%m-%d %H:%M:%S")


jpeg(file = "plot3.jpeg", width = 480, height = 480, units = "px")

with(Subdata, plot(combine, Sub_metering_1  , type = "n" , ylab = ""))
with(Subdata, lines(combine, Sub_metering_1 ))
with(Subdata, lines(combine, Sub_metering_2, col = "red" ))
with(Subdata, lines(combine, Sub_metering_3, col = "blue" ))
legend("topright" , col = c("black" , "red" , "blue") , lty = 1, cex = 1 ,
       lwd =2.5, legend = c("Sub_metering_1", "Sub_metering_2" ,"Sub_metering_3")  )

dev.off()
