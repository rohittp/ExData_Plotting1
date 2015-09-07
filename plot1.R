library(sqldf)
library(lubridate)
library(dplyr)
# get working directory
wd<-getwd() 
# get file path of file household_power_consumption.txt 
filepath<-file.path(wd,"household_power_consumption.txt",fsep = .Platform$file.sep)
# read file using sqldf. Only read rows where dates are 1/2/2007 or 2/2/2007
x<-read.csv2.sql(filepath,sql="select * from file 
where Date in('1/2/2007','2/2/2007')",header = TRUE,na.strings ="?")
# add column datetime which is a concatenation of Date & Time column
x<-mutate(x,datetime=paste(Date,Time))
# convert datetime column to POSIXlt using strptime
x$datetime<-strptime(x$datetime,"%d/%m/%Y %H:%M:%S")
#plot the histogram in a png file in the working directory. The default width & hieght is 480 pixels.
png(filename="plot1.png")
hist(x$Global_active_power,col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power")
dev.off()