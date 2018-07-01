setwd("C:\\temp\\exdata_data_NEI_data")
#load the sqldf and ggplot2 libraries
library(sqldf)
library(ggplot2)
#inform R to use SQLite db
options(sqldf.driver = "SQLite")
#load the data from file
ssp <- readRDS("./summarySCC_PM25.rds")
#get the year, type and total emissions for Baltimore
dat <- sqldf("select year as Year,type as Type, sum(emissions) as Emissions from ssp where fips = '24510' group by year, type")
#save the file to png
png(file = "./plot3.png")
gg <- ggplot(data=dat,aes(x=Year,y=Emissions)) + geom_point(aes(color=Type)) + geom_line(aes(color=Type))
gg <- gg + labs(title="Baltimore")
print(gg)
dev.off()