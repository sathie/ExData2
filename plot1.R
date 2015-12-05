#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?

#Load dplyr
library(dplyr)

#Read data
emsums <- readRDS("summarySCC_PM25.rds") %>%                    #Read data
        tbl_df %>%                                              #Convert to tbl_df
        group_by(year) %>%                                      #Group by year
        summarize(emissions = sum(Emissions))                   #Get sum of emissions for each year

#Draw barplot
png(file = "plot1.png", height = 480, width = 640)
barplot(emsums$emissions, names.arg = c(1999, 2002, 2005, 2008), main = "Total emissions by year", xlab = "Year", ylab = "Total emissions (in tons)", col = "light blue")

text(0.7, 7000000, round(emsums[1,2], digits = 0))
text(1.9, 6000000, round(emsums[2,2], digits = 0))
text(3.1, 5800000, round(emsums[3,2], digits = 0))
text(4.3, 3800000, round(emsums[4,2], digits = 0))

dev.off()

#Conclusion: Total emissions have decreased from 1999 to 2008.