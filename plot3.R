#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable,
#which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?
#Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

#Load dplyr and ggplot2
library(dplyr)
library(ggplot2)

#Read data
typesums <- readRDS("summarySCC_PM25.rds") %>%                   #read data
        tbl_df %>%                                              #convert to tbl_df
        filter(fips == 24510) %>%                               #filter only rows that contain data for Baltimore City, Maryland
        group_by(year, type) %>%                                #group by year and type
        summarize(emissions = sum(Emissions))                   #get sum of emissions for each year and type

#Make plot
png(file = "plot3.png", height = 480, width = 640)
qplot(year, emissions, data = typesums, color = type, geom = "line", main = "Emissions in Baltimore City by type", ylab = "Emissions (in tons)", xlab = "Year")
dev.off()