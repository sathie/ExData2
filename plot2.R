#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?

#Load dplyr
library(dplyr)

#Read data
baltisums <- readRDS("summarySCC_PM25.rds") %>%                 #read data
        tbl_df %>%                                              #convert to tbl_df
        filter(fips == 24510) %>%                               #filter only rows that contain data for Baltimore City, Maryland
        group_by(year) %>%                                      #group by year
        summarize(emissions = sum(Emissions))                   #get sum of emissions for each year

#Draw barplot
png(file = "plot2.png", height = 480, width = 640)
barplot(baltisums$emissions, names.arg = c(1999, 2002, 2005, 2008), main = "Total emissions in Baltimore City, Maryland by year", xlab = "Year", ylab = "Total emissions (in tons)", col = "light blue")

text(0.7, 3100, round(baltisums[1, 2], digits = 0))
text(1.9, 2250, round(baltisums[2, 2], digits = 0))
text(3.1, 2900, round(baltisums[3, 2], digits = 0))
text(4.3, 1700, round(baltisums[4, 2], digits = 0))

dev.off()