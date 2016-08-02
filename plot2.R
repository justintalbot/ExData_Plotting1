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

#create the second plot with proper parameters
png("plot2.png",width = 480, height = 480)

#the second graph
plot(s_power$datetime, s_power$Global_active_power, ylab = "Global Active Power (kilowatts)",
     type = "n", xlab = " ")
lines(s_power$datetime, s_power$Global_active_power)

# close the dev
dev.off()