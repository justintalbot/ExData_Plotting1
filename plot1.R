#load in dplyr for subsetting later
library(dplyr)

#read in the dataset
power <- read.table("household_power_consumption.txt", header = TRUE,sep=";",
                    na.strings="?",stringsAsFactors = FALSE)


#convert the date variable from factor to date
power$Date <- as.Date(power$Date, format = "%d/%m/%Y")

#filter out the two dates we will be working with
s_power <- filter(power, Date == "2007-02-01" | Date == "2007-02-02")

#create the first plot with proper parameters
png("plot1.png",width = 480, height = 480)

#first graph
hist(s_power$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")

#close the dev
dev.off()