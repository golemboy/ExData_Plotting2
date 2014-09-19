##Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
##Which city has seen greater changes over time in motor vehicle emissions?

require("plyr")
require("ggplot2")

#set path
#setwd("/your/working/directory")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

cities <- data.frame(c("24510","06037"),c("Baltimore City","Los Angeles County"))
colnames(cities) <- c("fips","City")

#use Emission in Baltimore City and Los Angeles County
bc_la_NEI <- NEI[NEI$fips %in% cities$fips & NEI$type == "ON-ROAD",]
bc_la_NEI <- merge(bc_la_NEI, cities, by = "fips")

#aggregate with ddply by year and City
aggreg <- ddply(bc_la_NEI, c("year","City"), summarise, amount=sum(Emissions))
breaks <- as.vector(unique(aggreg$year))

#plot6
png(filename = "plot6.png", width = 480, height = 480, units = "px")
g <- ggplot(aggreg, aes(x = year, y = amount, fill = factor(year))) + theme(legend.position='none')
g <- g + geom_bar(stat="identity")
g <- g + facet_wrap(~ City)
g <- g + scale_x_continuous(breaks=breaks)
g <- g + ggtitle('Emissions from motor vehicle sources\nBaltimore City / Los Angeles County') + ylab("PM2.5 Emission (Tons)") + xlab("Year")
g
dev.off()
