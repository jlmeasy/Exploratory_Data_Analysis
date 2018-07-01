setwd("C:\\temp\\exdata_data_NEI_data")
#load the sqldf library
library(sqldf)
#use the SQLite db
options(sqldf.driver = "SQLite")
#load the data
ssp <- readRDS("./summarySCC_PM25.rds")
#get the year and the total PM2.5 emission
finalDat <- sqldf("select year, sum(emissions) as emissions from ssp group by year")
#plot the year and emission and export it to file
png(file = "./plot1.png")
plot(finalDat$year, finalDat$emissions, xlab="Year", ylab="Emissions")
lines(finalDat$year,finalDat$emissions,col=2)
dev.off()
