#script for plot 1

library(dplyr)
library(lubridate)

# get the data from off the internet
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFile <- download.file(url, "./data.zip")
unzip("./data.zip")
file.remove("./data.zip")


#include only the data that is needed for the graph
data<-read.table("household_power_consumption.txt",sep=";",header=TRUE)%>%
    mutate(Date = dmy(Date))%>%
    mutate(Global_active_power=as.numeric(Global_active_power))%>%
    filter(Date >= dmy("1/2/2007") & Date <= dmy("2/2/2007"))%>%
    select(Global_active_power)

#create the png graphic device
png(filename = "plot1.png",width = 480, height = 480, units = "px")

#make the histogram
with(data,hist(Global_active_power,col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power",axes=FALSE))
axis(1,seq(0,6,2),lwd=2)
axis(2,seq(0,1200,200),lwd=2)


#close the png device
dev.off()

