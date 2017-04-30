
data <- read.table("household_power_consumption.txt"  , sep = ";" , header = TRUE)

str(data)

library(lubridate)

data$Date <- dmy(data$Date) 

Subdata <- subset(data , c(Date == '2007-02-02' |  Date == '2007-02-01'))

Subdata$Global_active_power <- gsub("?",NA, Subdata$Global_active_power , fixed =TRUE)

Subdata[,3:9] <- sapply(Subdata[,3:9],as.numeric)

jpeg(file = "plot1.jpeg", width = 480, height = 480, units = "px")

with(Subdata, hist(Global_active_power ,col ="Red" , xlab = "Global Active Power (kilowatts)" , main= "Global Active Power"))

dev.off()
