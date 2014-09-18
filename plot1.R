
##Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
##Using the base plotting system, 
##make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

require("plyr")

#set path
#setwd("/your/working/directory")


## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#aggregate with ddply, convert and round Emissions in Kilotons
aggreg <- ddply(NEI, c("year"), summarise, amount=round(sum(Emissions)/1000,2))

#plot1
png(filename = "plot1.png", width = 480, height = 480, units = "px")
barplot(aggreg$amount, names.arg = aggreg$year,              
              main = "Total PM2.5 emission", 
              xlab = "Year", ylab="PM2.5 emission (Ktons)")

dev.off()
