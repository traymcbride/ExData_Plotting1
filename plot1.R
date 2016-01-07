#############################################################
#Construct Plot #1 for Project 1 - Exploratory Data Analysis
#############################################################

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
#zeroes for month or day values less than 10.  We need not worry
#about converting dates and time for our simple histogram.

ElectricData <- filter(ElectricData,Date == "2/2/2007" | Date == "1/2/2007")

#Produce the plot.  For png, the default width and height both equal 480, and
#the units are pixels, which is what we want.

png(filename="plot1.png")
hist(ElectricData$Global_active_power,col="red",main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()


