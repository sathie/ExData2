#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

#Load dplyr and ggplot2
library(dplyr)
library(ggplot2)

#Read in source classification data and search of SCC of motor vehicle sources
classification <- readRDS("Source_Classification_Code.rds") %>%
        tbl_df %>%
        filter(Data.Category == "Onroad")
motor2 <- classification[, 1] %>%
        as.list()
motor2 <- motor2[[1]]

#Read data, filter Baltimore City, filter motor vehicle related sources, group by year and summarize
motorems <- readRDS("summarySCC_PM25.rds") %>%                  #read data
        tbl_df %>%                                              #convert to tbl_df
        filter(fips == 24510) %>%                               #filter only rows that contain data for Baltimore City, Maryland
        filter(SCC %in% motor2) %>%
        group_by(year) %>%
        summarize(emissions = sum(Emissions))

#Make plot
png(file = "plot5.png", height = 480, width = 640)
qplot(year, emissions, data = motorems, geom = "line", main = "Emissions from motor vehicles in Baltimore City", ylab = "Emissions (in tons)", xlab = "Year")
dev.off()