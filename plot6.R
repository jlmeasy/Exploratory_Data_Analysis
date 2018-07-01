setwd("C:\\temp\\exdata_data_NEI_data")
#load the sqldf and ggplot2 libraries
library(ggplot2)
library(sqldf)
#tell R to use SQLite db
options(sqldf.driver = "SQLite")
#load the data from file
ssp <- readRDS("./summarySCC_PM25.rds")
#get the total emissions per year for all the motor vehicles in Baltimore and Los Angeles County, California
dat <- sqldf("select year as Year, fips as Fips, sum(emissions) as Emissions from ssp where (fips = '24510' OR fips = '06037') and type= 'ON-ROAD' group by year, fips")
#save the file to PNG format
png(file = "./plot6.png")
gg <- ggplot(data=dat,aes(x=Year,y=Emissions)) + geom_point(aes(color=Fips)) + geom_line(aes(color=Fips))
gg <- gg + labs(title="Emissions from Motor Vehicle in Baltimore Compared to Los Angeles")
print(gg)
dev.off()