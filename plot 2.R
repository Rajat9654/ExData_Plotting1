library(lubridate)

data <- read.table("household_power_consumption.txt"  , sep = ";" , header = TRUE)

data$Date <- dmy(data$Date) 

Subdata <- subset(data , c(Date == '2007-02-02' |  Date == '2007-02-01'))

Subdata$Global_active_power <- gsub("?",NA, Subdata$Global_active_power , fixed =TRUE)

Subdata[,3:9] <- sapply(Subdata[,3:9],as.numeric)

Subdata$combine <- strptime(paste(Subdata$Date, Subdata$Time, sep=" "), "%Y-%m-%d %H:%M:%S")

jpeg(file = "plot2.jpeg", width = 480, height = 480, units = "px")

plot(Subdata$combine, Subdata$Global_active_power , type = "l" , xlab = "" 
     , ylab = "Global Active Power (kilowatts)")

dev.off()

