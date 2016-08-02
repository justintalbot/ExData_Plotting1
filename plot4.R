#load in dplyr for subsetting later
library(dplyr)
library(lubridate)

#read in the dataset
power <- read.table("household_power_consumption.txt", header = TRUE,sep=";",
                    na.strings="?",stringsAsFactors = FALSE)

#convert the date variable from factor to date
power$Date <- as.Date(power$Date, format = "%d/%m/%Y")

#filter out the two dates we will be working with
s_power <- filter(power, Date == "2007-02-01" | Date == "2007-02-02")

#make a new column combining date and time, courtesy of Vidor Ingason in the forums for week 1
s_power$datetime <- ymd_hms(apply(s_power[,1:2], 1, paste, collapse=" ")) 

#create the fourth plot with proper parameters
png("plot4.png",width = 480, height = 480)

#set up the window for four graphs
par(mfcol = c(2,2))

#graph 1 of 4
plot(s_power$datetime, s_power$Global_active_power, ylab = "Global Active Power (kilowatts)",
     type = "n", xlab = " ")
lines(s_power$datetime, s_power$Global_active_power)
par(mar = c(5.1, 4.1, 2.1, 1.1))

#graph 2 of 4
plot(s_power$datetime, s_power$Sub_metering_1, type = "n", xlab = " ", ylab = "Energy sub metering")
lines(s_power$datetime, s_power$Sub_metering_1, col = "black")
lines(s_power$datetime, s_power$Sub_metering_2, col = "red")
lines(s_power$datetime, s_power$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1), 
       col = c("black", "red", "blue"), bty = "n")
par(mar = c(5.1, 4.1, 2.1, 1.1))

#graph 3 of 4
plot(s_power$datetime, s_power$Voltage, ylab = "Voltage", xlab = "datetime", type = "n")
lines(s_power$datetime, s_power$Voltage)
par(mar = c(5.1, 4.1, 2.1, 1.1))

#graph 4 of 4
plot(s_power$datetime, s_power$Global_reactive_power, ylab = "Global Reactive Power",
     type = "n", xlab = "datetime")
lines(s_power$datetime, s_power$Global_reactive_power)
par(mar = c(5.1, 4.1, 2.1, 1.1))

#close the dev
dev.off()