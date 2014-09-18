#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
#which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
#Which have seen increases in emissions from 1999-2008? 
#Use the ggplot2 plotting system to make a plot answer this question.

require("plyr")
require("ggplot2")

#set path
#setwd("/your/working/directory")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#use Emission in Baltimore City
bc_NEI <- NEI[NEI$fips == "24510",]

#aggregate with ddply by year and type
aggreg <- ddply(bc_NEI, c("year","type"), summarise, amount=sum(Emissions))
breaks <- as.vector(unique(aggreg$year))

#plot3
png(filename = "plot3.png", width = 480, height = 480, units = "px")
g <- ggplot(aggreg, aes(x = year, y = amount, fill = factor(type)))
g <- g + geom_bar(stat="identity") 
g <- g + facet_wrap(~ type)
g <- g + scale_x_continuous(breaks=breaks)
g <- g + ggtitle('PM2.5 Emission per Type in Baltimore City') + ylab("PM2.5 Emission (Tons)") + xlab("Year")
g
dev.off()
