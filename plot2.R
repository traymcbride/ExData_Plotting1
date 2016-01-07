#############################################################
#Construct Plot #2 for Project 1 - Exploratory Data Analysis
#############################################################

library(lubridate)
library(dplyr)

#Read in the data and change all question marks to NA.
#See row 6841 as an example in the dataset.

ElectricData <- read.table("household_power_consumption.txt",sep=";",
                           header=TRUE,dec=".",stringsAsFactors=FALSE,
                           na.strings = "?")

#Remove all NA entries

good_rows <- complete.cases(ElectricData)
ElectricData <- ElectricData[good_rows,]

#Grab only those dates were interested in, Feb 1 and 2 of 2007.
#The dates in the file are in dd/mm/yyyy format, with no leading
#zeroes for month or day values less than 10.

ElectricData <- filter(ElectricData,Date == "2/2/2007" | Date == "1/2/2007")

#Put the date and time together in a new column, TimeStamp.
#We use the lubridate package's dmy_hms.  For example, "1/2/2007 03:03:00" 
#becomes "2007-02-01 03:03:00 UTC".  Actual timezone is irrelevant for this
#plot. We leave it at UTC.

ElectricData <- mutate(ElectricData, TimeStamp = dmy_hms(paste(Date,Time)))

#Produce the plot.  Note TimeStamp will be delineated with tick marks at 
#day of the week on the x-axis.  We're spanning 48 hours, namely Thu
#through Fri, so the final tick mark will be Sat.

png(filename="plot2.png")
with(ElectricData,plot(TimeStamp,Global_active_power,type="l",xlab="",
                       ylab="Global Active Power (kilowatts)"))
dev.off()
