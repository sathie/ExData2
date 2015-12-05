#Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

#Load dplyr and ggplot2
library(dplyr)
library(ggplot2)

#Read source classification code
classification <- readRDS("Source_Classification_Code.rds") %>%
        tbl_df

#Search SCC of coal combustion related sources
fuelcomb <- grepl("^fuel comb -(.*)- coal$", classification$EI.Sector, ignore.case = TRUE)
class2 <- classification[fuelcomb, 1] %>%
        as.list()
class2 <- class2[[1]]

#Read data, filter coal combustion related sources, group by year, summarize
coalcomb <- readRDS("summarySCC_PM25.rds") %>%                   #read data
        tbl_df %>%                                               #convert to tbl_df
        filter(SCC %in% class2) %>%
        group_by(year) %>%
        summarize(emissions = sum(Emissions))

#Make plot
png(file = "plot4.png", height = 480, width = 640)
qplot(year, emissions, data = coalcomb, geom = "line", main = "Emissions from coal combustion-related sources in the US", ylab = "Emissions (in tons)", xlab = "Year")
dev.off()