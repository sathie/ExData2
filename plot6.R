#Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County,
#California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

#Load dplyr and ggplot2
library(dplyr)
library(ggplot2)

#Read source classification code and search for SCC of motor vehicle sources
classification <- readRDS("Source_Classification_Code.rds") %>%
        tbl_df %>%
        filter(Data.Category == "Onroad")

motor2 <- classification[, 1] %>%
        as.list()
motor2 <- motor2[[1]]

#Read data, filter fips and motor vehicle related sources, group by year and fips, summarize
motorems2 <- readRDS("summarySCC_PM25.rds") %>%                 #read data
        tbl_df %>%                                              #convert to tbl_df
        filter(fips %in% c("24510", "06037")) %>%
        filter(SCC %in% motor2) %>%
        group_by(year, fips) %>%
        summarize(emissions = sum(Emissions))

motorems2$fips <- gsub("06037", "Los Angeles County", motorems2$fips)
motorems2$fips <- gsub("24510", "Baltimore City", motorems2$fips)

#Make plot
png(file = "plot6.png", height = 480, width = 640)
qplot(year, emissions, data = motorems2, geom = "line", color = fips, main = "Emissions from motor vehicle sources in Baltimore City and Los Angeles County", ylab = "Emissions (in tons)", xlab = "Year")
dev.off()