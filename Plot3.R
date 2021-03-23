##First, read the data
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./data/Power.zip", method="curl")

unzip(zipfile="./data/Power.zip",exdir="./data")

powerFull <- read.table("./data/household_power_consumption.txt", header = TRUE, 
                        sep = ";", na.strings = "?")

##Subset the data to just 2007-02-01 and 2007-02-02
power <- subset(powerFull, Date %in% c("1/2/2007","2/2/2007"))

##This may mean converting Date and Time varaibles to proper class
power$Date <- as.Date(power$Date, format="%d/%m/%Y")
power$DateTime <- paste(power$Date, power$Time)
power$DateTime <- as.POSIXct(power$DateTime, template = "%d/%m/%Y %H:%M:%S")

##Then, create the plot
##The first plot will be a hist x=Global Active Power (kilowatts)
##y=Frequency, Title=Global Active Poewr, Color = Red
##The second plot will not have a title or an X axis label
##but X=Time, y= Global Active Power (kilowatts)
##The third plot will not have a title or x axis label but
##X=Time,y= Energy sub metering, legend = Sub_meterings,
##where 1 is black, 2 is red, and 3 is blue
par(mfrow=c(1,1))
plot(power$DateTime,power$Sub_metering_1,xlab="",
     ylab="Energy sub metering", type="n")
lines(power$DateTime,power$Sub_metering_1)
lines(power$DateTime,power$Sub_metering_2, col="red")
lines(power$DateTime,power$Sub_metering_3, col="blue")
legend("topright",pch="_____",col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

##The fourth is a series of four plots, the first of which is
##x=time, y=Global Active Power, the second is x=datetime,
##y=voltage, the third is x=time, y=Energy sub metering, includes
##a legend where 1 is black, 2 is red, and 3 is blue, and the 
##fourth is x=datetime, y=Global_reactive_power.



##Then, save as png with a width of 480 pixels 
##and a height of 480 pixels.
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()