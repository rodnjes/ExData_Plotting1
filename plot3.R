#script for plot 3

library(dplyr)
library(lubridate)

# get the data from off the internet
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFile <- download.file(url, "./data.zip")
unzip("./data.zip")
file.remove("./data.zip")

#include only the data that is needed for the graph
data<-read.table("household_power_consumption.txt",sep=";",header=TRUE) %>%
    mutate(DateTime=dmy_hms(paste(Date,Time))) %>%
    filter(DateTime >= dmy("1/2/2007") & DateTime <= dmy("3/2/2007"))%>%
    mutate(Sub_metering_1=as.numeric(Sub_metering_1))%>%
    mutate(Sub_metering_2=as.numeric(Sub_metering_2))%>%
    mutate(Sub_metering_3=as.numeric(Sub_metering_3))%>%
    select(c(Sub_metering_1,Sub_metering_2,Sub_metering_3,DateTime))

#create the png graphic device
png(filename = "plot3.png",width = 480, height = 480, units = "px")

#make the plot

with(data,{
    plot(DateTime,Sub_metering_1,ylab="Energy sub metering ",xlab=" ",type="l",axes=FALSE,frame.plot=TRUE)
    points(DateTime,Sub_metering_2,col = "red",type="l")
    points(DateTime,Sub_metering_3,col = "blue",type="l")
    axis.POSIXct(1,seq(min(data$DateTime),max(data$DateTime),"days"),format="%a")
    axis(2,at=seq(0,30,10))
    legend("topright",lwd=1,col=c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
    
})

#close the png device
dev.off()

