#setwd("C:/Users/Olivier/Desktop/Coursera/exdata-006/ExData_Plotting2")

#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
#Use the base plotting system to make a plot answering this question.

require("plyr")

#set path
#setwd("/your/working/directory")


## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#use Emission in Baltimore City
bc_NEI <- NEI[NEI$fips == "24510",]

#aggregate with ddply, convert and round Emissions in Kilotons
aggreg <- ddply(bc_NEI, c("year"), summarise, amount=round(sum(Emissions)/1000,2))

#plot2
png(filename = "plot2.png", width = 480, height = 480, units = "px")
barplot(aggreg$amount, names.arg = aggreg$year,              
        main = "Total PM2.5 emission in Baltimore City",
        xlab = "Year", ylab="PM2.5 emission (Ktons)")

dev.off()
