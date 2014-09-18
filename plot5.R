##How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City? 
require("plyr")
require("ggplot2")

#set path
#setwd("/your/working/directory")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#use Emission in Baltimore City
bc_NEI <- NEI[NEI$fips == "24510" & NEI$type == "ON-ROAD",]

#aggregate with ddply by year
aggreg <- ddply(bc_NEI, c("year"), summarise, amount=sum(Emissions))
breaks <- as.vector(unique(aggreg$year))

#plot5
png(filename = "plot5.png", width = 480, height = 480, units = "px")
g <- ggplot(aggreg, aes(x = year, y = amount, fill = factor(year))) + theme(legend.position='none')
g <- g + geom_bar(stat="identity") 
g <- g + scale_x_continuous(breaks=breaks)
g <- g + ggtitle('Total Emissions of Motor Vehicle Sources in Baltimore City') + ylab("PM2.5 Emission (Tons)") + xlab("Year")
g
dev.off()
