#script for plot 4

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
    mutate(Global_active_power=as.numeric(Global_active_power))%>%
    mutate(Global_reactive_power=as.numeric(Global_reactive_power))%>%
    mutate(Voltage = as.numeric(Voltage)) %>%
    mutate(Sub_metering_1=as.numeric(Sub_metering_1))%>%
    mutate(Sub_metering_2=as.numeric(Sub_metering_2))%>%
    mutate(Sub_metering_3=as.numeric(Sub_metering_3))%>%
    mutate(Global_intensity=as.numeric(Global_intensity))%>%
    select(c(Global_active_power,Global_reactive_power,Voltage,Global_intensity,Sub_metering_1,Sub_metering_2,Sub_metering_3,DateTime))
head(data)
#create the png graphic device
png(filename = "plot4.png",width = 480, height = 480, units = "px")

#partition the screen for 4 plot areas
par(mfrow=c(2,2),mar = c(4,4,2,2),oma=c(0,0,0,0))
#plot1
with(data,{
    plot(DateTime,Global_active_power,ylab="Global Active Power",xlab=" ",type="l",axes=FALSE,frame.plot=TRUE)
    axis.POSIXct(1,seq(min(data$DateTime),max(data$DateTime),"days"),format="%a")
    axis(2,at=seq(0,6,2))
    
})

#plot 2
with(data,{
    plot(DateTime,Voltage,ylab="Voltage",xlab="datetime ",type="l",axes=FALSE,frame.plot=TRUE)
    axis.POSIXct(1,seq(min(data$DateTime),max(data$DateTime),"days"),format="%a")
    axis(2,at=seq(234,246,2))

    
})



#plot3
with(data,{
    plot(DateTime,Sub_metering_1,ylab="Energy sub metering ",xlab=" ",type="l",axes=FALSE,frame.plot=TRUE)
    points(DateTime,Sub_metering_2,col = "red",type="l")
    points(DateTime,Sub_metering_3,col = "blue",type="l")
    axis.POSIXct(1,seq(min(data$DateTime),max(data$DateTime),"days"),format="%a")
    axis(2,at=seq(0,30,10))
    legend("topright",bty="n",lwd=1,col=c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
    
})

#plot 4
with(data,{
    plot(DateTime,Global_reactive_power,ylab="Global_reactive_power",xlab="datetime ",type="l",axes=FALSE,frame.plot=TRUE)
    axis.POSIXct(1,seq(min(data$DateTime),max(data$DateTime),"days"),format="%a")
    axis(2,at=seq(0,.7,.1))

    
})




#close the png device
dev.off()

