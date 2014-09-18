##Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?
require("reshape2")
require("plyr")

#set path
#setwd("/your/working/directory")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#filter  coal combustion-related Sector
#coal_combustion <- SCC[grepl("Coal", SCC$EI.Sector),c(1,4)]
coal_combustion <- SCC[grepl("Coal", SCC$Short.Name),c(1,3)]

#merge with NEI (inner join)
NEI_CC <- merge(NEI,coal_combustion, by = "SCC")

aggreg <- ddply(NEI_CC, c("year"), summarise, amount=sum(Emissions)/1000)
breaks <- as.vector(unique(aggreg$year))

#plot4
png(filename = "plot4.png", width = 480, height = 480, units = "px")
g <- ggplot(aggreg, aes(x = year, y = amount, col="red")) + theme(legend.position='none')
g <- g + geom_line() 
g <- g + scale_x_continuous(breaks=breaks)
g <- g + ggtitle('Coal combustion-related sources PM2.5 Emission') + ylab("PM2.5 Emission (Ktons)") + xlab("Year")
g
dev.off()
