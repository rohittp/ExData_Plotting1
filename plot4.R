library(sqldf)
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
#Plot graphs to png file
png(filename="plot4.png")
# set multipanel plot parameter 2X2
par(mfrow=c(2,2))
# plot the four graphs rowwise on the png file
plot(x$datetime,x$Global_active_power,type="l",ylab="Global Active Power",xlab="")    
plot(x$datetime,x$Voltage,xlab="datetime",ylab="Voltage",type="l")
plot(x$datetime,x$Sub_metering_1 ,type="l",ylab="Energy sub metering",xlab="")
lines(x$datetime,x$Sub_metering_2,col="red")
lines(x$datetime,x$Sub_metering_3,col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue"))
plot(x$datetime,x$Global_reactive_power,xlab="datetime",ylab="Global_reactive_power",type="l")
dev.off()