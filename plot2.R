setwd("C:\\temp\\exdata_data_NEI_data")
#load the sqldf library
library(sqldf)
#use the SQLite db
options(sqldf.driver = "SQLite")
#load the data from file
ssp <- readRDS("./summarySCC_PM25.rds")
#sum-up the total emissions per year
dat <- sqldf("select year, sum(emissions) as emissions from ssp where fips = '24510' group by year")
#save the graph to PNG file
png(file = "./plot2.png")
plot(dat$year, dat$emissions, xlab="Year", ylab="Emissions",main = "Baltimore")
lines(dat$year,dat$emissions,col=2)
dev.off()
