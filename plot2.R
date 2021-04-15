#script for plot 2

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
    select(c(Global_active_power,DateTime))

#create the png graphic device
png(filename = "plot2.png",width = 480, height = 480, units = "px")

#make the plot

with(data,{
    plot(DateTime,Global_active_power,ylab="Global Active Power (kilowatts)",xlab=" ",type="l",axes=FALSE,frame.plot=TRUE)
    axis.POSIXct(1,seq(min(data$DateTime),max(data$DateTime),"days"),format="%a")
    axis(2,at=seq(0,6,2))

})

#close the png device
dev.off()

